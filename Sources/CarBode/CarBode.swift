//
//  ContentView.swift
//  CarBode
//
//  Created by narongrit kanhanoi on 7/10/2562 BE.
//  Copyright © 2562 PAM. All rights reserved.
//

import SwiftUI
import AVFoundation

public struct CarBode: UIViewRepresentable {

    public var supportBarcode: [AVMetadataObject.ObjectType]

    public typealias UIViewType = CameraPreview

    let delegate = Delegate()
    let session = AVCaptureSession()

    public func interval(delay:Double)-> CarBode {
        delegate.scanInterval = delay
        return self
    }

    public func found(r: @escaping (String) -> Void) -> CarBode {
        delegate.onResult = r
        return self
    }

    func setupCamera(_ uiView: CameraPreview) {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {

                let metadataOutput = AVCaptureMetadataOutput()

                session.sessionPreset = .photo

                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)
                    metadataOutput.metadataObjectTypes = supportBarcode
                    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                }
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)

                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer

                session.startRunning()
            }
        }
    }

    public func makeUIView(context: UIViewRepresentableContext<CarBode>) -> CarBode.UIViewType {
        return CameraPreview(frame: .zero)
    }

    public func updateUIView(_ uiView: CameraPreview, context: UIViewRepresentableContext<CarBode>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)

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
    }

}

public class CameraPreview: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    override public func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}

class Delegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var scanInterval:Double = 3.0
    var lastTime = Date(timeIntervalSince1970: 0)

    var onResult: (String) -> Void = { _ in }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            let now = Date()
            if now.timeIntervalSince(lastTime) >= scanInterval {
                lastTime = now
                self.onResult(stringValue)
            }
        }

    }
}

