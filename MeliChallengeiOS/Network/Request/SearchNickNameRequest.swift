import Foundation

struct SearchNickNameRequest: NetworkRequest {
    typealias Response = SearchProductNicknameResponse

    var path: String { "sites/MLB/domain_discovery/search" }
    var method: String { "GET" }
    var parameters: [String : Any] {
        ["q" : nickname]
    }
    var headers: [String : String]? { nil }
    var body: Data? {
        nil
    }

    let nickname: String
}
