import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import crypto_exchanges

class ExchangeViewModelSpec: QuickSpec {
    override class func spec() {
        var viewModel: ExchangeViewModel!
        var mockAPIService: MockExchangeAPI!
        var disposeBag: DisposeBag!

        beforeEach {
            mockAPIService = MockExchangeAPI()
            viewModel = ExchangeViewModel(apiService: mockAPIService)
            disposeBag = DisposeBag()
        }

        describe("ExchangeViewModel") {
            context("when fetching exchanges and icons") {
                it("should combine exchanges and icons correctly") {
                    var receivedExchangesWithIcons: [(Exchange, ExchangeIcon?)] = []
                    viewModel.output.exchangesWithIcons
                        .drive(onNext: { exchangesWithIcons in
                            receivedExchangesWithIcons = exchangesWithIcons
                        })
                        .disposed(by: disposeBag)


                    expect(receivedExchangesWithIcons.count).toEventually(equal(23))
                    expect(receivedExchangesWithIcons[0].0.name).to(equal("OKCoin CNY"))
                    expect(receivedExchangesWithIcons[1].0.name).to(equal("Huobi (HBUS)"))
                }
            }
            describe("ExchangeViewModel") {
                context("when applying filters") {
                    it("should filter exchanges by rank 1") {
                        var receivedExchangesWithIcons: [(Exchange, ExchangeIcon?)] = []
                        viewModel.output.exchangesWithIcons
                            .drive(onNext: { exchangesWithIcons in
                                receivedExchangesWithIcons = exchangesWithIcons
                            })
                            .disposed(by: disposeBag)

                        viewModel.input.filterSwitchRelay.accept([1])

                        expect(receivedExchangesWithIcons.count).toEventually(equal(7))
                        expect(receivedExchangesWithIcons[0].0.name).to(equal("Binance"))
                    }
                }
            }
            
            
            describe("ExchangeViewModel") {
                context("when selecting an exchange") {
                    it("should trigger navigation to exchange details") {
                        var receivedNavigationEvent: NavigationEventExchangeList?
                        viewModel.output.navigationEvent
                            .emit(onNext: { event in
                                receivedNavigationEvent = event
                            })
                            .disposed(by: disposeBag)

                        viewModel.input.selectedIndexRelay.accept(0)

                        expect(receivedNavigationEvent).toEventuallyNot(beNil())
                        if case let .goToListExchange(details) = receivedNavigationEvent {
                            expect(details.exchange.name).to(equal("OKCoin CNY"))
                         }
                    }
                }
            }
        }
    }
}
