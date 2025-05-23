import Foundation

final class SearchManager {
    // MARK: - Properties
    private let networkService: NetworkService

    // MARK: - Initializier
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods
    func search(nickname: String, completion: @escaping (Result<SearchNickNameResponse, Error>) -> Void) {
        let request = SearchNickNameRequest(nickname: nickname)
        networkService.send(request, completion: completion)
    }
}
