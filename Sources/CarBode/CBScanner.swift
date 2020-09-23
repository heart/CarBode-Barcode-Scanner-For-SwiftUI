//
//  ContentView.swift
//  CarBode
//
//  Created by narongrit kanhanoi on 7/10/2562 BE.
//  Copyright © 2562 PAM. All rights reserved.
//

import SwiftUI
import AVFoundation

class ScannerConfiguration {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var cameraSide = AVCaptureDevice.Position.back
}

public struct CBScanner: UIViewRepresentable {
    
    private var config = ScannerConfiguration()
    
    public var supportBarcode: [AVMetadataObject.ObjectType]?
    public typealias UIViewType = CameraPreview

    private let session = AVCaptureSession()
    private let delegate = CarBodeCameraDelegate()
    private let metadataOutput = AVCaptureMetadataOutput()

    public init(supportBarcode: [AVMetadataObject.ObjectType]) {
        self.supportBarcode = supportBarcode
    }

    public func torchLight(isOn: Bool) -> CBScanner {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                if isOn {
                    backCamera.torchMode = .on
                } else {
                    backCamera.torchMode = .off
                }
                backCamera.unlockForConfiguration()
            }
        }
        return self
    }

    public func interval(delay: Double) -> CBScanner {
        delegate.scanInterval = delay
        return self
    }

    public func found(r: @escaping (BarcodeData) -> Void) -> CBScanner {
        delegate.onResult = r
        return self
    }

    public func simulator(mockBarCode: BarcodeData) -> CBScanner {
        delegate.mockData = mockBarCode
        return self
    }

    public func camera(position: AVCaptureDevice.Position) {
        config.cameraSide = position
        
        print("position = \(position)")
    }

    
    func setupCamera(_ uiView: CameraPreview) {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: config.cameraSide)
        let camera = deviceDiscoverySession.devices.first
        if let selectedCamera = camera {
            if let input = try? AVCaptureDeviceInput(device: selectedCamera) {
                session.sessionPreset = .photo

                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)

                    metadataOutput.metadataObjectTypes = supportBarcode
                    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                }
                
                config.previewLayer?.removeFromSuperlayer()
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                
                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer
                
                config.previewLayer = previewLayer
                
                session.startRunning()
            }
        }

    }
    
    public func makeUIView(context: UIViewRepresentableContext<CBScanner>) -> CBScanner.UIViewType {
        let cameraView = CameraPreview(session: session)

        #if targetEnvironment(simulator)
            cameraView.createSimulatorView(delegate: self.delegate)
        #else
            checkCameraAuthorizationStatus(cameraView)
        #endif

        return cameraView
    }

    public static func dismantleUIView(_ uiView: CameraPreview, coordinator: ()) {
        uiView.session.stopRunning()
    }

    private func checkCameraAuthorizationStatus(_ uiView: CameraPreview) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }

        DispatchQueue.global(qos: .background).async {
            var isActive = true
            while(isActive) {
                DispatchQueue.main.sync {
                    if !self.session.isInterrupted && !self.session.isRunning {
                        isActive = false
                    }
                }
                sleep(1)
            }
        }
    }

    public func updateUIView(_ uiView: CameraPreview, context: UIViewRepresentableContext<CBScanner>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.updateCameraView()
    }

}

public class CameraPreview: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    private var label: UILabel?
    var delegate: CarBodeCameraDelegate?

    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getVideoOrientation() -> AVCaptureVideoOrientation {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, windowScene.activationState == .foregroundActive
            else { return .portrait }

        let interfaceOrientation = windowScene.interfaceOrientation

        switch interfaceOrientation {
        case .unknown:
            return .portrait
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        @unknown default:
            return .portrait
        }
    }

    func updateCameraView() {
        previewLayer?.connection?.videoOrientation = getVideoOrientation()
    }

    func createSimulatorView(delegate: CarBodeCameraDelegate) {
        self.delegate = delegate
        self.backgroundColor = UIColor.black
        label = UILabel(frame: self.bounds)
        label?.numberOfLines = 4
        label?.text = "CarBode Scanner View\nSimulator mode\n\nClick here to simulate scan"
        label?.textColor = UIColor.white
        label?.textAlignment = .center
        if let label = label {
            addSubview(label)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        self.addGestureRecognizer(gesture)
    }

    @objc func onClick() {
        delegate?.onSimulateScanning()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        #if targetEnvironment(simulator)
            label?.frame = self.bounds
        #else
            previewLayer?.frame = self.bounds
        #endif
    }
}

class CarBodeCameraDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var scanInterval: Double = 3.0
    var lastTime = Date(timeIntervalSince1970: 0)

    var onResult: (BarcodeData) -> Void = { _ in }
    var mockData: BarcodeData?

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            if let stringValue = readableObject.stringValue {
                let barcode = BarcodeData(value: stringValue, type: readableObject.type)
                foundBarcode(barcode)
            }
        }
    }

    @objc func onSimulateScanning() {
        foundBarcode(mockData ?? BarcodeData(value: "Mock Value", type: .qr))
    }

    func foundBarcode(_ barcode: BarcodeData) {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            self.onResult(barcode)
        }
    }
}
