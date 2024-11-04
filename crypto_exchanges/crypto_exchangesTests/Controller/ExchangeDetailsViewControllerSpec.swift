import Quick
import Nimble
import Nimble_Snapshots
import RxSwift

@testable import crypto_exchanges

final class ExchangeDetailsViewControllerSpec: QuickSpec {
    override class func spec() {
        describe("ExchangeDetailsViewController") {
            var sut: ExchangeDetailsViewController!
            var mockViewModel: MockExchangeDetailsViewModel!
            
            beforeEach {
                mockViewModel = MockExchangeDetailsViewModel()
                sut = ExchangeDetailsViewController(viewModel: mockViewModel)
                
                WindowHelper.showInTestWindow(viewController: sut)
            }
            
            afterEach {
                WindowHelper.cleanTestWindow()
            }
            
            it("should display the correct exchange details") {
                mockViewModel.exchangeNameRelay.accept("Binance")
                mockViewModel.exchangeWebsiteRelay.accept("Visite o site oficial: https://www.binance.com")
                mockViewModel.volume1DayRelay.accept("Volume de negociação nas últimas 24h: 200M USD")
                mockViewModel.dataSymbolsCountRelay.accept("Quantidade de pares de negociação disponíveis: 1.200")
                mockViewModel.dataPeriodRelay.accept("Período de coleta de dados: 2021 - 2022")
                mockViewModel.exchangeIconURLRelay.accept("https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/32a3ccb439ba4d20b995fd61194c5e18.png")
                expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(2))
            }
        }
    }
}
