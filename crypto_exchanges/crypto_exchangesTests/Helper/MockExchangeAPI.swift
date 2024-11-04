import Foundation
import RxSwift
import crypto_exchanges

class MockExchangeAPI: ExchangeAPIProtocol {
    
    var shouldReturnError = false
    
    let mockExchanges: [Exchange] = {
        var exchange = [Exchange]()
        
        if let jsonData = Bundle.main.loadJsonData(fileName: "json-exchange") {
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                exchange = try decoder.decode([Exchange].self, from: jsonData)
            } catch {
                print("\(error)")
            }
        } else {
            print("Error loading json")
        }
        
        return exchange
    }()
    
    let mockExchangeIcons: [ExchangeIcon] = {
        var exchange = [ExchangeIcon]()
        
        if let jsonData = Bundle.main.loadJsonData(fileName: "exchange-icon") {
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                exchange = try decoder.decode([ExchangeIcon].self, from: jsonData)
            } catch {
                print("\(error)")
            }
        } else {
            print("Error loading json")
        }
        
        return exchange
    }()

    
    func fetchExchanges() -> Single<[Exchange]> {
        return Single.create { single in
            if self.shouldReturnError {
                single(.failure(MockError.apiError))
            } else {
                single(.success(self.mockExchanges))
            }
            return Disposables.create()
        }
    }
    
    func fetchExchangeIcons() -> Single<[ExchangeIcon]> {
        return Single.create { single in
            if self.shouldReturnError {
                single(.failure(MockError.apiError))
            } else {
                single(.success(self.mockExchangeIcons))
            }
            return Disposables.create()
        }
    }
}

enum MockError: Error {
    case apiError
}
