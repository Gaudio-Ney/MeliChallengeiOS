import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    func getSearch(inputValue: String?, isMock: Bool)
}

protocol SearchViewModelDelegate: AnyObject {
    func showError(error: Error)
    func updateCollectionViewWithResponse(products: [Product])
}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: - Properties
    weak var delegate: SearchViewModelDelegate?

    private let searchManager: SearchManagerProtocol
    private let tokenManager = TokenManagerBuilder.makeTokenManager()

    // MARK: - Initializers
    init(searchManager: SearchManagerProtocol) {
        self.searchManager = searchManager
    }

    func getSearch(inputValue: String?, isMock: Bool) {
        guard let inputValue else {
            delegate?.showError(error: APIError.badRequest)
            return
        }
        search(nickname: inputValue, isMock: isMock)
    }
}

// MARK: - Private Methods
private extension SearchViewModel {
    func search(
        nickname: String,
        isMock: Bool
    ) {
        searchManager.search(nickname: nickname, isMock: isMock) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        guard let products = response.products else {
                            self?.delegate?.showError(error: APIError.noDataError)
                            return
                        }
                        self?.delegate?.updateCollectionViewWithResponse(products: products)
                    case .failure(let error):
                        self?.delegate?.showError(error: error)
                }
            }
        }
    }

    func getNewBearerToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        tokenManager.getAuthToken { result in
            switch result {
                case .success(let tokenResponse):
                    guard let accessToken = tokenResponse.accessToken else {
                        completion(.failure(APIError.noDataError))
                        return
                    }

                    TokenDefaults.saveAuthToken(token: accessToken)
                    Constants.ApiTokens.token = accessToken
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
