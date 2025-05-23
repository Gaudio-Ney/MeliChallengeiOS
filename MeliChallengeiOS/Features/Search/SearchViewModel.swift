import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    func getSearch(inputValue: String?)
}

protocol SearchViewModelDelegate: AnyObject {
    func showError()
}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: - Properties
    weak var delegate: SearchViewModelDelegate?

    private let searchManager: SearchManager
    // MARK: - Initializers
    init(searchManager: SearchManager) {
        self.searchManager = searchManager
    }

    func getSearch(inputValue: String?) {
        guard let inputValue else {
            delegate?.showError()
            return
        }
        search(nickname: inputValue)
    }
}

// MARK: - Private Methods
private extension SearchViewModel {
    func search(nickname: String) {
        searchManager.search(nickname: nickname) { result in
            switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
}
