struct ProductDetailFactory {
    static func makeSearchViewController(
        product: Product
    ) -> ProductDetailViewController {
        let viewModel = ProductDetailViewModel(product: product)
        let viewController = ProductDetailViewController(viewModel: viewModel)
        return viewController
    }
}
