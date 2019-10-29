![CarBode](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/logo.png)

# CarBode-Barcode-Scanner-For-SwiftUI
CarBode : Free &amp; Opensource barcode scanner for SwiftUI

![SwiftUI QRCode Scanner](https://raw.githubusercontent.com/heart/CarBode-Barcode-Scanner-For-SwiftUI/master/logo/preview.png)


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

