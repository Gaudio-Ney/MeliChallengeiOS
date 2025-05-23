import Foundation

final class ConsoleNetworkLogger: NetworkLogger {

    func logRequest(_ request: URLRequest) {
        print("➡️ [REQUEST]")
        if let url = request.url {
            print("URL: \(url.absoluteString)")
        }
        print("Method: \(request.httpMethod ?? "N/A")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
    }

    func logResponse(data: Data?, response: URLResponse?, error: Error?) {
        print("⬅️ [RESPONSE]")
        if let urlResponse = response as? HTTPURLResponse {
            print("Status code: \(urlResponse.statusCode)")
            print("URL: \(urlResponse.url?.absoluteString ?? "N/A")")
        }
        if let data = data,
           let jsonString = String(data: data, encoding: .utf8) {
            print("Body: \(jsonString)")
        }
        if let error = error {
            print("❌ Error: \(error.localizedDescription)")
        }
    }
}
