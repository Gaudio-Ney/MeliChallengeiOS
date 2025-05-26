import Foundation

protocol NetworkRequest {
    associatedtype Response: Decodable
    var path: String { get }
    var method: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}
