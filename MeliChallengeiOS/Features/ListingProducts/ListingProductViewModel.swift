import Foundation

protocol ListingProductViewModelProtocol: AnyObject {
    var delegate: ListingProductViewModelDelegate? { get set }
    func getProducts() -> [Product]
}

protocol ListingProductViewModelDelegate: AnyObject {

}

final class ListingProductViewModel: ListingProductViewModelProtocol {
    // MARK: - Properties
    weak var delegate: ListingProductViewModelDelegate?

    private let products: [Product]

    // MARK: - Initializers
    init(products: [Product]) {
        self.products = products
    }

    func getProducts() -> [Product] {
        products
    }
}
