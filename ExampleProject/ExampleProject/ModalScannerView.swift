//
//  ModalScannerView.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 7/1/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI
import CarBode
import AVFoundation

struct ModalScannerView: View {
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State var showingAlert = false
    @State var cameraPosition = AVCaptureDevice.Position.back

    var body: some View {
        VStack {
            Text("QRCode Scanner")

            Spacer()
            
            if cameraPosition == .back{
                Text("Using back camera")
            }else{
                Text("Using front camera")
            }
            
            Button(action: {
                if cameraPosition == .back {
                    cameraPosition = .front
                }else{
                    cameraPosition = .back
                }
            }) {
                if cameraPosition == .back{
                    Text("Swicth Camera to Front")
                }else{
                    Text("Swicth Camera to Back")
                }
            }
            
            
            Button(action: {
                self.torchIsOn.toggle()
            }) {
                Text("Toggle Torch Light")
            }

            Spacer()
            
            CBScanner(
                supportBarcode: .constant([.qr, .code128]),
                torchLightIsOn: $torchIsOn,
                cameraPosition: $cameraPosition,
                mockBarCode: .constant(BarcodeData(value:"My Test Data", type: .qr))
            ){
                print($0)
            }
            onDraw: {
                print("Preview View Size = \($0.cameraPreviewView.bounds)")
                print("Barcode Corners = \($0.corners)")
                
                let lineColor = UIColor.green
                let fillColor = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.4)
                
                //Draw Barcode corner
                $0.draw(lineWidth: 1, lineColor: lineColor, fillColor: fillColor)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)
            
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
