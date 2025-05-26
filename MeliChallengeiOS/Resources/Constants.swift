import Foundation

struct Constants {
    // MARK: - Base URLs
    struct BaseApiUrl {
        static let kBaseMeliURL = "https://api.mercadolibre.com"
    }

    // MARK: - Refresh Token
    struct ApiTokens {
        static var kTGRefreshToken = "TG-6834cfe1d375aa000174ab8f-103144126"
        static var token: String = "APP_USR-536635687162796-052616-cae58e4840a95a03ffa8244521480999-103144126"
    }

    // MARK: - UserDefaults
    struct UserDefaultsKeys {
        static let kAuthToken = "kAuthToken_user_defaults"
    }
}
