//
//  BarcodeFrame.swift
//
//
//  Created by weera Kaew-uan on 12/10/2563 BE.
//

import UIKit


public struct BarcodeFrame {
    
    public let corners:[CGPoint]
    public let cameraPreviewView: UIView
    
    public func draw(lineWidth: CGFloat = 1, lineColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear) {
        
        let view = cameraPreviewView as! CameraPreview
        
        view.drawFrame(corners: corners,
            lineWidth: lineWidth,
            lineColor: lineColor,
            fillColor: fillColor)
    }
    
    

}
