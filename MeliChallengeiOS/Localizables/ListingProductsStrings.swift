import Foundation

enum ListingProductsStrings: String {
    case listingProductsNavigationBarTitle

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
