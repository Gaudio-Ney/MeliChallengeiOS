import Foundation

protocol TokenManagerProtocol {
    func getAuthToken(
        completion: @escaping (Result<TokenResponse, Error>) -> Void
    )
}

final class TokenManager: TokenManagerProtocol {
    // MARK: - Properties
    private let networkService: NetworkService

    // MARK: - Initializier
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods
    func getAuthToken(
        completion: @escaping (Result<TokenResponse, Error>) -> Void
    ) {
        let request = APITokenRequest()
        networkService.send(request, completion: completion)
    }
}
