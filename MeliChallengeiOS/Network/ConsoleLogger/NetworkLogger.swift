import Foundation

protocol NetworkLogger {
    func logRequest(_ request: URLRequest)
    func logResponse(data: Data?, response: URLResponse?, error: Error?)
}
