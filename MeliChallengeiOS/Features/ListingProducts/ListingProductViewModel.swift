import Foundation

protocol ListingProductViewModelProtocol: AnyObject {
    func getSearch()
}

protocol ListingProductViewModelDelegate: AnyObject {

}

final class ListingProductViewModel {
    // MARK: - Properties
    weak var delegate: ProductDetailViewModelDelegate?
    // MARK: - Initializers
    init() {

    }
}

