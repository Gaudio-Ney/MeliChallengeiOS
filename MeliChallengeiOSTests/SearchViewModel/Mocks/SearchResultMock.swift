@testable import MeliChallengeiOS

extension SearchProductNicknameResponse {
    static var searchResultMock: SearchProductNicknameResponse {
        return SearchProductNicknameResponse(products: productsResultMock)
    }

    static var productsResultMock: [Product] {
        return [
            Product.init(
                name: "Smartphone Samsung Galaxy S21 FE 5G 128GB",
                price: 2599.90,
                quantity: 15,
                freeShipping: true,
                imageURL: "https://http2.mlstatic.com/D_NQ_NP_2X_703888-MLU77107715778_062024-F.webp"
            ),
            Product.init(
                name: "Smartphone Samsung Galaxy S21 FE 5G 128GB",
                price: 2599.90,
                quantity: 15,
                freeShipping: true,
                imageURL: "https://http2.mlstatic.com/D_NQ_NP_2X_703888-MLU77107715778_062024-F.webp"
            ), Product.init(
                name: "Smartphone Samsung Galaxy S21 FE 5G 128GB",
                price: 2599.90,
                quantity: 15,
                freeShipping: true,
                imageURL: "https://http2.mlstatic.com/D_NQ_NP_2X_703888-MLU77107715778_062024-F.webp"
            )
        ]
    }

    static var productsNilResultMock: [Product]? {
        return nil
    }

    static var searchResultNilMock: SearchProductNicknameResponse {
        return SearchProductNicknameResponse(products: productsNilResultMock)
    }
}
