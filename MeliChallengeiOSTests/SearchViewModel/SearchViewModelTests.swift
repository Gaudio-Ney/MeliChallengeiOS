import XCTest
@testable import MeliChallengeiOS

final class SearchViewModelTests: XCTestCase {
    private var sut: SearchViewModel?
    private var expectation : XCTestExpectation?

    override func setUp() {
        super.setUp()
        let searchMangerStup = SearchManagerStup(searchResultMock: .searchResultMock)
        let viewModel = SearchViewModel(searchManager: searchMangerStup)
        sut = viewModel
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSuccessMockedSearch() throws {
        let expectation = expectation(description: "Delegate should be called")
        let delegateSpy = SearchViewModelDelegateSpy()
        delegateSpy.expectation = expectation
        sut?.delegate = delegateSpy

        sut?.getSearch(inputValue: "Apple", isMock: true)

        wait(for: [expectation], timeout: 1.5)

        guard let hasUpdateUI = delegateSpy.hasUpdateCollectionViewWithResponse else {
            XCTFail("Expected delegate to be called")
            return
        }


        XCTAssertTrue(hasUpdateUI, "Successfully update collectionViewList")
        XCTAssertNil(delegateSpy.hasShowErrorCalled, "Error message correctly not seted")
    }

    func testFailureMockedSearch() throws {
        let searchMangerStup = SearchManagerStup(error: APIError.badRequest)
        let viewModel = SearchViewModel(searchManager: searchMangerStup)
        sut = viewModel
        let expectation = expectation(description: "Delegate should be called")
        let delegateSpy = SearchViewModelDelegateSpy()
        delegateSpy.expectation = expectation
        sut?.delegate = delegateSpy

        sut?.getSearch(inputValue: "Apple", isMock: true)

        wait(for: [expectation], timeout: 1.5)

        guard let hasShowError = delegateSpy.hasShowErrorCalled else {
            XCTFail("Expected delegate to be called")
            return
        }


        XCTAssertTrue(hasShowError, "User feedback alert message successfully presented")
        XCTAssertNil(delegateSpy.hasUpdateCollectionViewWithResponse, "UI correctly not updated due error message")
    }
}
