//
//  ContentView.swift
//  CarBode
//
//  Created by narongrit kanhanoi on 7/10/2562 BE.
//  Copyright © 2562 PAM. All rights reserved.
//

import SwiftUI
import AVFoundation

public struct CBScanner: UIViewRepresentable {

    public typealias OnFound = (BarcodeData)->Void
    public typealias OnDraw = (BarcodeFrame)->Void
    
    public typealias UIViewType = CameraPreview
    
    @Binding
    public var supportBarcode: [AVMetadataObject.ObjectType]
    
    @Binding
    public var torchLightIsOn:Bool
    
    @Binding
    public var zoom:Double
    
    @Binding
    public var scanInterval: Double
    
    @Binding
    public var cameraPosition:AVCaptureDevice.Position
    
    @Binding
    public var mockBarCode: BarcodeData

    public let isActive: Bool
    
    public var onFound: OnFound?
    public var onDraw: OnDraw?
    
    public init(supportBarcode:Binding<[AVMetadataObject.ObjectType]> ,
         torchLightIsOn: Binding<Bool> = .constant(false),
                zoom: Binding<Double> = .constant(2.0),
         scanInterval: Binding<Double> = .constant(3.0),
         cameraPosition: Binding<AVCaptureDevice.Position> = .constant(.back),
         mockBarCode: Binding<BarcodeData> = .constant(BarcodeData(value: "barcode value", type: .qr)),
         isActive: Bool = true,
         onFound: @escaping OnFound,
         onDraw: OnDraw? = nil
    ) {
        _torchLightIsOn = torchLightIsOn
        _zoom = zoom
        _supportBarcode = supportBarcode
        _scanInterval = scanInterval
        _cameraPosition = cameraPosition
        _mockBarCode = mockBarCode
        self.isActive = isActive
        self.onFound = onFound
        self.onDraw = onDraw
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CBScanner>) -> CBScanner.UIViewType {
        let view = CameraPreview()
        view.scanInterval = scanInterval
        view.supportBarcode = supportBarcode
        view.setupScanner()
        view.onFound = onFound
        view.onDraw = onDraw
        view.mockBarCode = mockBarCode
        view.torchLightIsOn = torchLightIsOn
        return view
    }

    public static func dismantleUIView(_ uiView: CameraPreview, coordinator: ()) {
        uiView.session?.stopRunning()
    }

    public func updateUIView(_ uiView: CameraPreview, context: UIViewRepresentableContext<CBScanner>) {

        if uiView.session?.isRunning == true && uiView.selectedCamera != nil {
            uiView.setTorchLight(isOn: torchLightIsOn)
        }
        uiView.zoom(to: zoom)
        uiView.setCamera(position: cameraPosition)
        uiView.scanInterval = scanInterval
        uiView.setSupportedBarcode(supportBarcode: supportBarcode)
        
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        if isActive {
            if !(uiView.session?.isRunning ?? false) {
                DispatchQueue.global().async {
                    uiView.session?.startRunning()
                }
            }
            uiView.updateCameraView()
        } else {
            uiView.session?.stopRunning()
        }
    }
}
