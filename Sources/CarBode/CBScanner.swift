//
//  ContentView.swift
//  CarBode
//
//  Created by narongrit kanhanoi on 7/10/2562 BE.
//  Copyright © 2562 PAM. All rights reserved.
//

import SwiftUI
import AVFoundation

typealias OnFound = (BarcodeData)->Void

public struct CBScanner: UIViewRepresentable {

    public typealias UIViewType = CameraPreview
    
    @Binding
    var supportBarcode: [AVMetadataObject.ObjectType]
    
    @Binding
    var torchLightIsOn:Bool
    
    @Binding
    var scanInterval: Double
    
    @Binding
    var cameraPosition:AVCaptureDevice.Position
    
    @Binding
    var mockBarCode: BarcodeData
    
    var onFound: OnFound?
    
    init(supportBarcode:Binding<[AVMetadataObject.ObjectType]> ,
         torchLightIsOn: Binding<Bool> = .constant(false),
         scanInterval: Binding<Double> = .constant(3.0),
         cameraPosition: Binding<AVCaptureDevice.Position> = .constant(.back),
         mockBarCode: Binding<BarcodeData> = .constant(BarcodeData(value: "barcode value", type: .qr)),
         onFound: @escaping OnFound
    ) {
        _torchLightIsOn = torchLightIsOn
        _supportBarcode = supportBarcode
        _scanInterval = scanInterval
        _cameraPosition = cameraPosition
        _mockBarCode = mockBarCode
        self.onFound = onFound
    }
    
    public func makeUIView(context: UIViewRepresentableContext<CBScanner>) -> CBScanner.UIViewType {
        let view = CameraPreview()
        view.scanInterval = scanInterval
        view.supportBarcode = supportBarcode
        view.setupScanner()
        view.onFound = onFound
        return view
    }

    public static func dismantleUIView(_ uiView: CameraPreview, coordinator: ()) {
        uiView.session?.stopRunning()
    }

    public func updateUIView(_ uiView: CameraPreview, context: UIViewRepresentableContext<CBScanner>) {
        
        uiView.setTorchLight(isOn: torchLightIsOn)
        uiView.setCamera(position: cameraPosition)
        uiView.scanInterval = scanInterval
        uiView.setSupportedBarcode(supportBarcode: supportBarcode)
        
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.updateCameraView()
    }

}
