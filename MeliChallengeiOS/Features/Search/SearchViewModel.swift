import Foundation

protocol SearchViewModelProtocol: AnyObject {
    func getSearch()
}

protocol SearchViewModelDelegate: AnyObject {

}

final class SearchViewModel {
    // MARK: - Properties
    weak var delegate: SearchViewModelDelegate?
    // MARK: - Initializers
    init() {

    }
}
