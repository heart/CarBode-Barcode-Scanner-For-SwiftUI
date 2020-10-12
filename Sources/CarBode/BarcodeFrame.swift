//
//  BarcodeFrame.swift
//
//
//  Created by weera Kaew-uan on 12/10/2563 BE.
//

import UIKit

public struct BarcodeFrame {

    let lineWidth: CGFloat
    let lineColor: UIColor
    let fillColor: UIColor
    
    public init(lineWidth: CGFloat = 1, lineColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear) {
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.fillColor = fillColor
    }

}
