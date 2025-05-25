import Foundation

enum APIError: Error {
    case urlError
    case notFound
    case badRequest
    case serverError
    case noDataError
    case unknownError

    var errorDescription: String {
        switch self {
        case .urlError:
            return "Não foi possível criar o objeto URL a partir da string fornecida."
        case .notFound:
            return "Erro 404, serviço não encontrado."
        case .badRequest:
            return "Erro ao enviar os dados para o Servidor."
        case .serverError:
            return "Erro Interno do Servidor."
        case .noDataError:
            return "Nenhum dado enviado pelo Servidor."
        case .unknownError:
            return "Algo de errado aconteceu."
        }
    }
}

final class NetworkService {
    // MARK: - Properties
    private let baseURL: URL
    private let session: URLSession

    private let consoleLogger = ConsoleNetworkLogger()

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
        var fullURL = baseURL.appendingPathComponent(request.path)
        var components = URLComponents(string: fullURL.absoluteString)!
        components.queryItems = request.parameters.map { (key, value) in
            URLQueryItem(name: key, value: value as? String)
        }

        fullURL = fullURL.appending(queryItems: components.queryItems!)

        guard let url = components.url else {
            return completion(.failure(APIError.urlError))
        }

        var urlRequest = URLRequest(url: fullURL)
        urlRequest = Interceptor.attachHeaders(to: urlRequest)
        urlRequest.httpMethod = request.method
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        consoleLogger.logRequest(urlRequest)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            self.consoleLogger.logResponse(data: data, response: response, error: error)
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

    func decodeSeachMock<T: NetworkRequest>(
        _ request: T,
        completion: @escaping (Result<T.Response, Error>
        ) -> Void) {
        guard let filePath = Bundle.main.path(forResource: "SearchResponseMock", ofType: "json") else {
            completion(.failure(APIError.noDataError))
            return
        }
        let fileUrl = URL(fileURLWithPath: filePath)

        do {
            guard let data = try? Data(contentsOf: fileUrl) else {
                completion(.failure(APIError.noDataError))
                return
            }

            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.Response.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(APIError.noDataError))
        }
    }
}
