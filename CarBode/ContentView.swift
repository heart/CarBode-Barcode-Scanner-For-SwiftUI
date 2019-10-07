//
//  ContentView.swift
//  CarBode
//
//  Created by narongrit kanhanoi on 7/10/2562 BE.
//  Copyright © 2562 PAM. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {


    var body: some View {
        VStack{
            CarBode(supportBarcode: [.qr])
                    .interval(delay: 5.0)
                       .found{ code in
                            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                           print(code)
                       }

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
