import Foundation

final class Interceptor {
    static func attachHeaders(to request: URLRequest) -> URLRequest {
        var req = request
        if !(req.url?.absoluteString.contains("oauth/token") ?? true) {
            req.addValue("Bearer \(Constants.ApiTokens.token)", forHTTPHeaderField: "Authorization")
            return req
        } else {
            return req
        }
    }
}
