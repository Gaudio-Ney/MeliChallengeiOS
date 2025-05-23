import Foundation

protocol SearchViewModelProtocol: AnyObject {
    func getSearch(inputValue: String)
}

protocol SearchViewModelDelegate: AnyObject {

}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: - Properties
    weak var delegate: SearchViewModelDelegate?

    private let searchManager: SearchManager
    // MARK: - Initializers
    init(searchManager: SearchManager) {
        self.searchManager = searchManager
    }

    func getSearch(inputValue: String) {
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
