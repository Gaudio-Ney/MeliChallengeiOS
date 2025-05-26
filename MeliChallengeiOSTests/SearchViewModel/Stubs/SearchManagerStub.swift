@testable import MeliChallengeiOS

final class SearchManagerStub: SearchManagerProtocol {
    private let result: Result<MeliChallengeiOS.SearchProductNicknameResponse, Error>

        init(searchResultMock: SearchProductNicknameResponse) {
            self.result = .success(searchResultMock)
        }

        init(error: Error) {
            self.result = .failure(error)
        }

    func search(
        nickname: String,
        isMock: Bool,
        completion: @escaping (Result<MeliChallengeiOS.SearchProductNicknameResponse, Error>) -> Void
    ) {
        completion(result)
    }
}
