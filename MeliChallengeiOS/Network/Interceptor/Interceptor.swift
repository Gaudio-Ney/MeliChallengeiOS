import Foundation

final class Interceptor {
    static func attachHeaders(to request: URLRequest) -> URLRequest {
        var req = request
        req.addValue("Bearer \(TokenManager.shared.token)", forHTTPHeaderField: "Authorization")
        return req
    }
}
