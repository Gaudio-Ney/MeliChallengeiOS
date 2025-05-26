import Foundation

struct SearchFactory {
    static func makeSearchViewController(
    ) -> SearchViewController {
        let baseURL = URL(string: Constants.BaseApiUrl.kBaseMeliURL)!
        let networkService = NetworkService(baseURL: baseURL)
        let searchManager = SearchManager(networkService: networkService)
        let viewModel = SearchViewModel(searchManager: searchManager)
        let viewController = SearchViewController(viewModel: viewModel)
        return viewController
    }
}
