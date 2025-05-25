struct ListingProductsFactory {
    static func makeListingViewController(
        products: [Product]
    ) -> ListingProductsViewController {
        let viewModel = ListingProductViewModel(products: products)
        let viewController = ListingProductsViewController(viewModel: viewModel)
        return viewController
    }
}
