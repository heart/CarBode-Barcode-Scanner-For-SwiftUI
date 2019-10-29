![CarBode](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/logo.png)

# CarBode-Barcode-Scanner-For-SwiftUI
CarBode : Free &amp; Opensource barcode scanner for SwiftUI

![SwiftUI QRCode Scanner](https://github.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/blob/master/logo/preview.png?raw=true)


# How to use

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

