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
    var body: some View {
        VStack{
            Text("QRCode Scanner")
            
            Spacer()
            
            CarBode(supportBarcode: [.qr, .code128])
            .interval(delay: 1.0)
               .found{
                self.barcodeValue = $0
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            
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
