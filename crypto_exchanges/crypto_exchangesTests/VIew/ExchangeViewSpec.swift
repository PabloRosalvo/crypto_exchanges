import Quick
import Nimble
import Nimble_Snapshots
import RxSwift

@testable import crypto_exchanges

class ExchangeViewSnapshotSpec: QuickSpec {
    override class func spec() {
        describe("ExchangeView layout") {
            var sut: ExchangeView!
            
            beforeEach {
                sut = ExchangeView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
                
                let mockExchanges = [
                    Exchange(exchangeID: "BINANCE",
                             website: "https://www.binance.com",
                             name: "Binance", dataQuoteStart: Date(),
                             dataQuoteEnd: Date(), dataOrderbookStart: Date(),
                             dataOrderbookEnd: Date(),
                             dataTradeStart: Date(),
                             dataTradeEnd: Date(),
                             dataSymbolsCount: 1200,
                             volume1HrsUSD: 5000000,
                             volume1DayUSD: 200000000,
                             volume1MthUSD: 10000000000, rank: 1),
                    Exchange(exchangeID: "KRAKEN",
                             website: "https://www.kraken.com",
                             name: "Kraken", dataQuoteStart: Date(),
                             dataQuoteEnd: Date(), dataOrderbookStart: Date(),
                             dataOrderbookEnd: Date(),
                             dataTradeStart: Date(),
                             dataTradeEnd: Date(),
                             dataSymbolsCount: 900,
                             volume1HrsUSD: 3000000,
                             volume1DayUSD: 150000000,
                             volume1MthUSD: 7500000000,
                             rank: 2)
                ]
                
                sut.loadModel(mockExchanges)
                
                sut.bindFilterOptions(["Rank 1", "Rank 2"])
            }
            
            afterEach {
               sut = nil
            }
            
            it("should display the correct layout with switches and table") {
                expect(sut).toEventually(recordSnapshot())
            }
        }
    }
}
