import Foundation

final class SearchManager {
    // MARK: - Properties
    private let networkService: NetworkService

    // MARK: - Initializier
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods
    func search(
        nickname: String,
        isMock: Bool = false,
        completion: @escaping (Result<SearchProductNicknameResponse, Error>
        ) -> Void) {
        let request = SearchNickNameRequest(nickname: nickname)
        if isMock {
            networkService.decodeSeachMock(request, completion: completion)
        } else {
            networkService.send(request, completion: completion)
        }
    }
}
