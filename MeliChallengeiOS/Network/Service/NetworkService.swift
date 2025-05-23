import Foundation

final class NetworkService {
    // MARK: - Properties
    private let baseURL: URL
    private let session: URLSession

    // MARK: - Initializer
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    // MARK: - Generic Methods
    func send<T: NetworkRequest>(
        _ request: T,
        completion: @escaping (Result<T.Response, Error>) -> Void
    ) {
        let fullURL = baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = request.method
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            }

            do {
                let decoded = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
