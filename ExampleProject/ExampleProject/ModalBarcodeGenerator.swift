//
//  ModalBarcodeGenerator.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 5/3/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI

struct ModalBarcodeGenerator: View {

    @State var dataString = "Hello Carbode"
    @State var barcodeType = CBBarcodeView.BarcodeType.qrCode
    @State var rotate = CBBarcodeView.Orientation.up

    var body: some View {
        VStack {
            CBBarcodeView(data: $dataString,
                barcodeType: $barcodeType,
                orientation: $rotate)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)

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
