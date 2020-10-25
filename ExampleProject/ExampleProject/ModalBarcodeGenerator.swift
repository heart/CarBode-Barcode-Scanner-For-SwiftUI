//
//  ModalBarcodeGenerator.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 5/3/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI
import CarBode

struct ModalBarcodeGenerator: View {

    @State var dataString = "Hello Carbode"
    @State var barcodeType = CBBarcodeView.BarcodeType.qrCode
    @State var rotate = CBBarcodeView.Orientation.up
    
    @State var barcodeImage: UIImage?

    var body: some View {
        VStack {
            CBBarcodeView(data: $dataString,
                barcodeType: $barcodeType,
                orientation: $rotate)
                { image in
                    self.barcodeImage = image
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            
            Spacer()
            Button(action: {
                if let barcodeImage = self.barcodeImage {
                    print("Image Size = \(barcodeImage.size.width) x \(barcodeImage.size.height)")
                }
            }) {
                Text("Print BarcodeSize to output")
            }
            Spacer()
            
            HStack {

                Spacer()

                Button(action: {
                    self.barcodeType = .qrCode
                }) {
                    Text("QR")
                }

                Spacer()

                Button(action: {
                    self.barcodeType = .barcode128
                }) {
                    Text("Barcode 128")
                }

                Spacer()

                Button(action: {
                    self.barcodeType = .aztecCode
                }) {
                    Text("Aztec")
                }

                Spacer()

                Button(action: {
                    self.barcodeType = .PDF417
                }) {
                    Text("PDF 417")
                }

                Spacer()
            }

            Spacer()

            HStack {

                Spacer()

                Button(action: {
                    self.rotate = .up
                }) {
                    Text("Rotate UP")
                }

                Spacer()

                Button(action: {
                    self.rotate = .down
                }) {
                    Text("Rotate DOWN")
                }

                Spacer()

                Button(action: {
                    self.rotate = .right
                }) {
                    Text("Rotate RIGHT")
                }

                Spacer()

                Button(action: {
                    self.rotate = .left
                }) {
                    Text("Rotate LEFT")
                }

                Spacer()
            }

            Spacer()

        }
    }
}

struct ModalBarcodeGenerator_Previews: PreviewProvider {
    static var previews: some View {
        ModalBarcodeGenerator()
    }
}
