import Foundation

struct SearchNickNameResponse: Decodable {
    let domainID, domainName, categoryID, categoryName: String?

    enum CodingKeys: String, CodingKey {
        case domainID = "domain_id"
        case domainName = "domain_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}
