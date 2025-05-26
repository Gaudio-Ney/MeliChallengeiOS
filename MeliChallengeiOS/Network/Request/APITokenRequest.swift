import Foundation

struct APITokenRequest: NetworkRequest {
    typealias Response = TokenResponse
    
    var path: String { "oauth/token" }

    var method: String { "POST"}
    
    var parameters: [String : Any] { [:] }

    var headers: [String : String]? {
        let dictionary = [
            "accept" : "application/json",
            "content-type" : "application/x-www-form-urlencoded"
        ]
        return dictionary
    }

    var body: Data? {
        let dictionary = [
            "grant_type" : "authorization_code",
            "client_id" : "536635687162796",
            "client_secret" : "tGC40PbawbjZmDtMnArqi9wTQEExj8wK",
            "code" : Constants.ApiTokens.kTGRefreshToken,
            "redirect_uri" : "https://melichallengeios.com/redirect",
        ]
        
        guard let jsonData = try? JSONEncoder().encode(dictionary) else {
            return nil
        }
        
        return jsonData
    }
}
