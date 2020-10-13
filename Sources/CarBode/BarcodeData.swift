
import AVFoundation
import UIKit

public struct BarcodeData {
    public let value: String
    public let type: AVMetadataObject.ObjectType

    public init(value: String, type: AVMetadataObject.ObjectType) {
        self.value = value
        self.type = type
    }
    
}
