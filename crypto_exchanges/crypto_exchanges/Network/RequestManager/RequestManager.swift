import Foundation

protocol RequestManagerProtocol {
    func request<T: Decodable>(
        baseURL: String,
        endpoint: APIEndpoint,
        method: HTTPMethodV2,
        parameters: ParametersV2?,
        headers: HTTPHeadersV2?,
        completion: @escaping (Result<T>) -> Swift.Void
    )
}

struct RequestManager: RequestManagerProtocol {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(
        baseURL: String,
        endpoint: APIEndpoint,
        method: HTTPMethodV2 = .get,
        parameters: ParametersV2? = nil,
        headers: HTTPHeadersV2? = nil,
        completion: @escaping (Result<T>) -> Swift.Void
    ) {
        guard let url = URL(string: baseURL + endpoint.path) else {
            completion(.failure(RequestError(reason: "Invalid URL", statusCode: 400, data: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        var updatedHeaders = headers ?? [:]
        updatedHeaders["X-CoinAPI-Key"] = "32524CF9-75BF-4A4A-93AA-460402AC4C2E"
        request.allHTTPHeaderFields = updatedHeaders
        request.httpBody = convertJsonForData(json: parameters)
        request.httpMethod = method.rawValue

        session.dataTask(with: request) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completion(.failure(RequestError(reason: "Invalid response", statusCode: 0, data: nil)))
                return
            }

            ResquestLog.requestLog(data: data, response: httpUrlResponse, error: error)

            guard (200...299).contains(httpUrlResponse.statusCode) else {
                completion(.failure(RequestError(reason: "HTTP Error", statusCode: httpUrlResponse.statusCode, data: data)))
                return
            }

            guard let data = data else {
                completion(.failure(RequestError(reason: "No data received", statusCode: httpUrlResponse.statusCode, data: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let decodedData = try decoder.decode(T.self, from: data)
                
                completion(.success(decodedData))
            } catch {
                completion(.failure(RequestError(reason: "Decoding error: \(error.localizedDescription)", statusCode: httpUrlResponse.statusCode, data: data)))
            }
        }.resume()
    }

    private func convertJsonForData(json: [String: Any]?) -> Data? {
        guard let json = json else { return nil }
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
