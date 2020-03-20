//
//  ModalScannerView.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 7/1/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI
struct ModalScannerView: View {
    @State var barcodeValue = ""
    @State var torceIsOn = false
    
    var body: some View {
        VStack{
            Text("QRCode Scanner")
            
            Spacer()
            
            Button(action: {
                self.torceIsOn.toggle()
            }) {
                Text("Toggle Torch Light")
            }
            
            Spacer()
            
            CBScanner(supportBarcode: [.qr, .code128])
            .interval(delay: 1.0)
            .found{
                print($0)
                self.barcodeValue = $0
            }
            .simulator(mockBarCode: "MOCK BARCODE DATA 1234567890")
            .torchLight(isOn: self.torceIsOn)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            
            Spacer()
            
            Text(barcodeValue)
            
        }
    }
}

struct ModalScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ModalScannerView()
    }
}
