import Foundation

public struct Exchange: Codable {
    let exchangeID: String?
    let website: String?
    let name: String?
    let dataQuoteStart: Date?
    let dataQuoteEnd: Date?
    let dataOrderbookStart: Date?
    let dataOrderbookEnd: Date?
    let dataTradeStart: Date?
    let dataTradeEnd: Date?
    let dataSymbolsCount: Int?
    let volume1HrsUSD: Double?
    let volume1DayUSD: Double?
    let volume1MthUSD: Double?
    let rank: Int?
    let metricID: [String]?

    enum CodingKeys: String, CodingKey {
        case exchangeID = "exchange_id"
        case website
        case name
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1HrsUSD = "volume_1hrs_usd"
        case volume1DayUSD = "volume_1day_usd"
        case volume1MthUSD = "volume_1mth_usd"
        case rank
        case metricID = "metric_id"
    }
}
