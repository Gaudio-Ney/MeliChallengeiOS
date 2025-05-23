import Foundation

struct SearchNickNameRequest: NetworkRequest {
    typealias Response = SearchNickNameResponse

    var path: String { "auth/login" }
    var method: String { "POST" }
    var headers: [String : String]? { ["Content-Type": "application/json"] }
    var body: Data? {
        try? JSONEncoder().encode(["nickname": nickname])
    }

    let nickname: String
}
