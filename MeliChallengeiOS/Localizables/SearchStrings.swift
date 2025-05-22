import Foundation

enum SearchStrings: String {
    case searchButtonTitle
    case searchNavigationBarTitle

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
