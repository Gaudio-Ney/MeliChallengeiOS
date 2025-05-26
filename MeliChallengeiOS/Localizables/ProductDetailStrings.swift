import Foundation

enum ProductDetailStrings: String {
    case freeShippingTitle
    case productQuantityDescription
    case detailNavigationBarTitle

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
