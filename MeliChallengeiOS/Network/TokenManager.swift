import Foundation

final class TokenManager {
    // MARK: - Propeties
    static let shared = TokenManager()

    var token: String = ""

    // MARK: - Initializers
    private init() {
        
    }
}
