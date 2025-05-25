import Foundation

struct SearchProductNicknameResponse: Decodable {
    let products: [Product]?
}
struct Product: Codable {
    let name: String?
    let price: Double?
    let quantity: Int?
    let freeShipping: Bool?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name, price, quantity
        case freeShipping = "free_shipping"
        case imageURL = "image_url"
    }
}
