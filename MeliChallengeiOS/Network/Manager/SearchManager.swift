import Foundation

protocol SearchManagerProtocol {
    func search(
        nickname: String,
        isMock: Bool,
        completion: @escaping (Result<SearchProductNicknameResponse, Error>) -> Void
    )
}

final class SearchManager: SearchManagerProtocol {
    // MARK: - Properties
    private let networkService: NetworkService

    // MARK: - Initializier
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods
    func search(
        nickname: String,
        isMock: Bool,
        completion: @escaping (Result<SearchProductNicknameResponse, Error>) -> Void
    ) {
        let request = SearchNickNameRequest(nickname: nickname)
        if isMock {
            networkService.decodeSeachMock(request, completion: completion)
        } else {
            networkService.send(request, completion: completion)
        }
    }
}
