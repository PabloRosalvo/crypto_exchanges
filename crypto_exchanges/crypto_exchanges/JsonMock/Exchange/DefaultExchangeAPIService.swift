//import RxSwift
//
//class DefaultExchangeAPIService: ExchangeAPIProtocol {
//
//    func fetchExchanges() -> Single<[Exchange]> {
//        return Single.create { single in
//            if let jsonData = Bundle.main.loadJsonData(fileName: "json-exchange") {
//                let decoder = JSONDecoder()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
//                decoder.dateDecodingStrategy = .formatted(dateFormatter)
//                do {
//                    let decodedExchanges = try decoder.decode([Exchange].self, from: jsonData)
//                    single(.success(decodedExchanges))
//                } catch {
//                    single(.failure(error))
//                }
//            } else {
//                single(.failure(RequestError(reason: "Failed to load JSON data", statusCode: 404, data: nil)))
//            }
//            
//            return Disposables.create()
//        }
//    }
//    
//    func fetchExchangeIcons() -> Single<[ExchangeIcon]> {
//        return Single.create { single in
//            if let jsonData = Bundle.main.loadJsonData(fileName: "json-exchange") {
//                let decoder = JSONDecoder()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
//                decoder.dateDecodingStrategy = .formatted(dateFormatter)
//                do {
//                    let decodedExchanges = try decoder.decode([ExchangeIcon].self, from: jsonData)
//                    single(.success(decodedExchanges))
//                } catch {
//                    single(.failure(error))
//                }
//            } else {
//                single(.failure(RequestError(reason: "Failed to load JSON data", statusCode: 404, data: nil)))
//            }
//            
//            return Disposables.create()
//        }
//    }
//}
