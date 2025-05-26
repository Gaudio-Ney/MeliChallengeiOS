import Foundation

enum TokenDefaults {
    static func saveAuthToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: Constants.UserDefaultsKeys.kAuthToken)
    }

    static func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.kAuthToken)
    }
}
