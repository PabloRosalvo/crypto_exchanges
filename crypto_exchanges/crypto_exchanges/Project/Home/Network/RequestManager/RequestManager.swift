//
//  RequestManager.swift
//
//  Created by Pablo Rosalvo on 27/01/22.


import Foundation

protocol RequestManagerProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethodV2, parameters: ParametersV2?, headers: HTTPHeadersV2?, completion: @escaping (Result<T>) -> Swift.Void)
}

struct RequestManager: RequestManagerProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(url: URL, method: HTTPMethodV2 = .get, parameters: ParametersV2? = nil, headers: HTTPHeadersV2? = nil, completion: @escaping (Result<T>) -> Swift.Void) {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpBody = convertJsonForData(json: parameters)
        request.httpMethod = method.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else { return }
            ResquestLog.requestLog(data: data, response: httpUrlResponse, error: error)
            let decoder = JSONDecoder()
            if httpUrlResponse.statusCode >= 200 && httpUrlResponse.statusCode <= 300 {
                guard let data = data else { return }
                let jsonData = try? decoder.decode(T.self, from: data)
                guard let json = jsonData else { return }
                completion(.success(json))
            } else {
                completion(.failure(RequestError(reason: error?.localizedDescription ?? "", statusCode: httpUrlResponse.statusCode, data: data)))
            }
        }.resume()
    }
    
    private func convertJsonForData(json: [String: Any]?) -> Data? {
        guard let json = json else { return nil }
        return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
