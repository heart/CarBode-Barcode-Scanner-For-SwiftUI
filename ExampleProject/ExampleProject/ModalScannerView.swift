//
//  ModalScannerView.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 7/1/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI
import CarBode

struct ModalScannerView: View {
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State var showingAlert = false

    var body: some View {
        VStack {
            Text("QRCode Scanner")

            Spacer()

            Button(action: {
                self.torchIsOn.toggle()
            }) {
                Text("Toggle Torch Light")
            }

            Spacer()

            CBScanner(supportBarcode: [.qr, .code128])
                .interval(delay: 1.0)
                .found {
                    print("Value=\($0.value)   Type=\($0.type.rawValue)")
                    self.barcodeValue = $0.value
                    self.showingAlert = true

                }
                .simulator(mockBarCode: BarcodeData(value: "MOCK BARCODE DATA 1234567890", type: .qr))
                .torchLight(isOn: self.torchIsOn)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)

            Spacer()

            Text(barcodeValue)

        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Found Barcode"), message: Text("\(barcodeValue)"), dismissButton: .default(Text("Close")))
        }
    }
}

struct ModalScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ModalScannerView()
    }
}
