import Foundation

protocol ProductDetailViewModelProtocol: AnyObject {
    func getSearch()
}

protocol ProductDetailViewModelDelegate: AnyObject {

}

final class ProductDetailViewModel {
    // MARK: - Properties
    weak var delegate: ProductDetailViewModelDelegate?
    // MARK: - Initializers
    init() {

    }
}
