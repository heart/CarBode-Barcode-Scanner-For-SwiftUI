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
    
    var body: some View {
        Button(action: {
            self.showingScanner.toggle()
        }) {
            Text("Open Scanner")
        }.sheet(isPresented: $showingScanner) {
            ModalScannerView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
