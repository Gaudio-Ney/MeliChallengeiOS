import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    func getSearch(inputValue: String?, isMock: Bool)
}

protocol SearchViewModelDelegate: AnyObject {
    func showError()
    func updateCollectionViewWithResponse(products: [Product])
}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: - Properties
    weak var delegate: SearchViewModelDelegate?

    private let searchManager: SearchManagerProtocol
    // MARK: - Initializers
    init(searchManager: SearchManagerProtocol) {
        self.searchManager = searchManager
    }

    func getSearch(inputValue: String?, isMock: Bool) {
        guard let inputValue else {
            delegate?.showError()
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
                            self?.delegate?.showError()
                            return
                        }
                        self?.delegate?.updateCollectionViewWithResponse(products: products)
                    case .failure(_):
                        self?.delegate?.showError()
                }
            }
        }
    }
}
