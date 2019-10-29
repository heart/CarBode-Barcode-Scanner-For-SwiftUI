![CarBode](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/logo.png)

# CarBode-Barcode-Scanner-For-SwiftUI
CarBode : Free &amp; Opensource barcode scanner for SwiftUI

![SwiftUI QRCode Scanner](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/preview.png)

# Installation

The preferred way of installing SwiftUIX is via the [Swift Package Manager](https://swift.org/package-manager/).

>Xcode 11 integrates with libSwiftPM to provide support for iOS, watchOS, and tvOS platforms.

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL (`https://github.com/heart/CarBode-Barcode-Scanner-For-SwiftUI`) and click **Next**.
3. For **Rules**, select **Branch** (with branch set to `master`).
4. Click **Finish**.


# Usage

## Add camera usage description to your `info.plist`

``` XML
<key>NSCameraUsageDescription</key>
<string>this app using camera to scan a barcode</string>
```

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            CarBode(supportBarcode: [.qr]) //Set type of barcode you want to scan
                    .interval(delay: 5.0) //Event will trigger every 5 seconds
                       .found{
                            //Your..Code..Here
                            print($0)
                      }
        }
    }
}
```

# Contributing

CarBode welcomes contributions in the form of GitHub issues and pull-requests.
