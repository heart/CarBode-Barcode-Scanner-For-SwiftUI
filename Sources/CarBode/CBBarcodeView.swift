//
//  File.swift
//
//
//  Created by narongrit kanhanoi on 5/3/2563 BE.
//

import Foundation
import SwiftUI


public struct CBBarcodeView: UIViewRepresentable {

    public enum BarcodeType: String {
        case qrCode = "CIQRCodeGenerator"
        case barcode128 = "CICode128BarcodeGenerator"
        case aztecCode = "CIAztecCodeGenerator"
        case PDF417 = "CIPDF417BarcodeGenerator"
    }

    public enum Orientation {
        case up
        case down
        case right
        case left
    }

    public typealias UIViewType = BarcodeView

    @Binding public var data: String
    @Binding public var barcodeType: BarcodeType
    @Binding public var orientation: Orientation
    
//    public init(data: String,
//                barcodeType: $barcodeType,
//                orientation: $rotate) {
//        self.supportBarcode = supportBarcode
//    }

    public func makeUIView(context: UIViewRepresentableContext<CBBarcodeView>) -> CBBarcodeView.UIViewType {
        return BarcodeView()
    }

    public func updateUIView(_ uiView: BarcodeView, context: UIViewRepresentableContext<CBBarcodeView>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        print("updateUIView")
        uiView.gen(data: data, barcodeType: barcodeType)
        uiView.rotate(orientation: orientation)
    }

}

public class BarcodeView: UIImageView {

    func gen(data: String?, barcodeType: CBBarcodeView.BarcodeType) {

        guard let string = data, !string.isEmpty else {
            self.image = nil
            return
        }

        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: barcodeType.rawValue)!
        filter.setValue(data, forKey: "inputMessage")
        let output = filter.outputImage

        let scaleX = self.bounds.width / output!.extent.size.width
        let scaleY = self.bounds.height / output!.extent.size.height

        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let scaledImage = output?.transformed(by: transform)

        let newImage = UIImage(ciImage: scaledImage!)
        self.image = newImage
    }

    private func radians (_ degrees: Float) -> Float {
        return degrees * .pi / 180
    }

    func rotate(orientation: CBBarcodeView.Orientation) {
        if (orientation == .right) {
            self.image = self.image?.rotate(radians: radians(90))
        } else if (orientation == .left) {
            self.image = self.image?.rotate(radians: radians(-90))
        } else if (orientation == .up) {
            self.image = self.image?.rotate(radians: radians(0))
        } else if (orientation == .down) {
            self.image = self.image?.rotate(radians: radians(180))
        }
    }
}

private extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
            context.rotate(by: CGFloat(radians))
            self.draw(in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}
