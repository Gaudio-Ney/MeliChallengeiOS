import Foundation

enum APIErrorStrings: String {
    case urlError
    case notFound
    case badRequest
    case serverError
    case noDataError
    case unknownError

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: ""  )
    }
}
