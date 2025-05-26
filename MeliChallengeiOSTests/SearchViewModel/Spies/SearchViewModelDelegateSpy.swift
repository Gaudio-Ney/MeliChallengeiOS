import XCTest
@testable import MeliChallengeiOS

final class SearchViewModelDelegateSpy: SearchViewModelDelegate {
    var expectation: XCTestExpectation?

    private(set) var hasShowErrorCalled: Bool?
    private(set) var hasUpdateCollectionViewWithResponse: Bool?

    var delegate: SearchViewModelDelegate? {
        didSet {
            delegate?.updateCollectionViewWithResponse(products: [])
        }
    }

    func showError() {
        hasShowErrorCalled = true
        expectation?.fulfill()
    }
    
    func updateCollectionViewWithResponse(products: [MeliChallengeiOS.Product]) {
        hasUpdateCollectionViewWithResponse = true
        expectation?.fulfill()
    }
}
