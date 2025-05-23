import Foundation

struct SearchNickNameResponse: Decodable {
    let name: String?
    let price: Double?
    let description: String?
    let imageURL: String?
}
