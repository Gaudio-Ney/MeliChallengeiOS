import Foundation

protocol ProductDetailViewModelProtocol: AnyObject {
    var delegate: ProductDetailViewModelDelegate? { get set }
    func getProduct() -> Product
}

protocol ProductDetailViewModelDelegate: AnyObject {

}

final class ProductDetailViewModel: ProductDetailViewModelProtocol {
    // MARK: - Properties
    weak var delegate: ProductDetailViewModelDelegate?

    private let product: Product

    // MARK: - Initializers
    init(product: Product) {
        self.product = product
    }

    func getProduct() -> Product {
        product
    }
}

// MARK: - Private Methods
private extension ProductDetailViewModel {

}
