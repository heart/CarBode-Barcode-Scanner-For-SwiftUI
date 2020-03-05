//
//  ContentView.swift
//  ExampleProject
//
//  Created by narongrit kanhanoi on 7/1/2563 BE.
//  Copyright © 2563 narongrit kanhanoi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingScanner = false
    @State var showingGenerator = false
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Button(action: {
                self.showingScanner.toggle()
            }) {
                Text("Open Scanner")
            }.sheet(isPresented: $showingScanner) {
                ModalScannerView()
            }
            
            Spacer()
            
            Button(action: {
                self.showingGenerator.toggle()
            }) {
                Text("Open Barcode Generator")
            }.sheet(isPresented: $showingGenerator) {
                ModalBarcodeGenerator()
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
