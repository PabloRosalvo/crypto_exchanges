import Foundation

enum APIEndpoint {
    case exchange
    case iconExchange
    var path: String {
        switch self {
        case .exchange:
            return "/v1/exchanges"
        case .iconExchange:
            return "/v1/exchanges/icons/64"
        }
    }
}