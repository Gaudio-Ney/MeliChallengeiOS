import Foundation

enum ListingProductsCellStrings: String {
    case freeShippingTitle
    case productQuantityDescription

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
