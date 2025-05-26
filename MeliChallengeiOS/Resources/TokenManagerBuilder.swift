import Foundation

enum TokenManagerBuilder {
    static func makeTokenManager() -> TokenManager {
        let baseURL = URL(string: Constants.BaseApiUrl.kBaseMeliURL)!
        let networkService = NetworkService(baseURL: baseURL)
        let tokenManager = TokenManager(networkService: networkService)
        return tokenManager
    }
}
