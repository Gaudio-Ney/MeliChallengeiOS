import Foundation

enum SearchStrings: String {
    case searchButtonTitle
    case searchNavigationBarTitle
    case searchErroAlertTitle

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
