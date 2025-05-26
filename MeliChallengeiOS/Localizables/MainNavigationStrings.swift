import Foundation

enum MainNavigationStrings: String {
    case backButtonTitle

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
