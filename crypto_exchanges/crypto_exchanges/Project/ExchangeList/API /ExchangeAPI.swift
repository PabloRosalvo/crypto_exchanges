import Foundation
import RxSwift
import RxCocoa

public protocol ExchangeAPIProtocol {
    func fetchExchanges() -> Single<[Exchange]>
    func fetchExchangeIcons() -> Single<[ExchangeIcon]>
}

public class ExchangeAPI: ExchangeAPIProtocol {
    private let requestManager: RequestManagerProtocol
    
    enum BaseUrl {
        static let url = "https://rest.coinapi.io"
    }
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    public func fetchExchanges() -> Single<[Exchange]> {
        return Single.create { single in
            self.requestManager.request(baseURL: BaseUrl.url,
                                        endpoint: .exchange,
                                        method: .get,
                                        parameters: nil,
                                        headers: nil) { (result: Result<[Exchange]>) in
                switch result {
                case .success(let exchanges):
                    single(.success(exchanges))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func fetchExchangeIcons() -> Single<[ExchangeIcon]> {
        return Single.create { single in
            self.requestManager.request(baseURL: BaseUrl.url,
                                        endpoint: .iconExchange,
                                        method: .get,
                                        parameters: nil,
                                        headers: nil) { (result: Result<[ExchangeIcon]>) in
                switch result {
                case .success(let icons):
                    single(.success(icons))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
