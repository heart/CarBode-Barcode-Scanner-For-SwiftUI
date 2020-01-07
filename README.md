![CarBode](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/logo.png)

# CarBode-Barcode-Scanner-For-SwiftUI
CarBode : Free &amp; Opensource barcode scanner for SwiftUI

![SwiftUI QRCode Scanner](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/preview.png)

# Installation

The preferred way of installing SwiftUIX is via the [Swift Package Manager](https://swift.org/package-manager/).

>Xcode 11 integrates with libSwiftPM to provide support for iOS, watchOS, and tvOS platforms.

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL (`https://github.com/heart/CarBode-Barcode-Scanner-For-SwiftUI`) and click **Next**.
3. For **Rules**, select **Branch** (with branch set to `1.0.1` ).
4. Click **Finish**.


# Usage

## Add camera usage description to your `info.plist`

``` XML
<key>NSCameraUsageDescription</key>
<string>This app needs access to the camera, to be able to read barcodes.</string>
```

```Swift
import SwiftUI
import CarBode

struct ContentView: View {
    var body: some View {
        VStack{
        CarBode(supportBarcode: [.qr, .code128]) //Set type of barcode you want to scan
                    .interval(delay: 5.0) //Event will trigger every 5 seconds
                       .found{
                            //Your..Code..Here
                            print($0)
                      }
        }
    }
}
```


# How to turn torch light on/off

```Swift
import SwiftUI
import CarBode

@State var torceIsOn = false

struct ContentView: View {
    var body: some View {
        VStack{

        Button(action: {
            self.torceIsOn.toggle()
        }) {
            Text("Toggle Torch Light")
        }
            
        Spacer()
        
        CarBode(supportBarcode: [.qr, .code128]) //Set type of barcode you want to scan
                    .torchLight(isOn: self.torceIsOn) // Turn torch light on/off
                    .interval(delay: 5.0) //Event will trigger every 5 seconds
                       .found{
                            //Your..Code..Here
                            print($0)
                      }
        }
    }
}
```

## Barcode Types Support
Read here [https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype) 

# Contributing

CarBode welcomes contributions in the form of GitHub issues and pull-requests.

## Changelog
    - 1.0.1 Fixed bug camera delay 10 seconds when use on modal.
    - 1.2.0 Add feature allows to turn torch light on or off.
