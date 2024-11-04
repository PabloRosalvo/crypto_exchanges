import RxSwift
import RxCocoa
import crypto_exchanges

class MockExchangeDetailsViewModel: ExchangeDetailsViewModelType {
    var input: ExchangeDetailsViewModelInput
    var output: ExchangeDetailsViewModelOutput
    
    let actionButtonTappedRelay = PublishRelay<Void>()
    let exchangeNameRelay = BehaviorRelay<String?>(value: nil)
    let exchangeWebsiteRelay = BehaviorRelay<String?>(value: nil)
    let volume1DayRelay = BehaviorRelay<String?>(value: nil)
    let dataSymbolsCountRelay = BehaviorRelay<String?>(value: nil)
    let dataPeriodRelay = BehaviorRelay<String?>(value: nil)
    let exchangeIconURLRelay = BehaviorRelay<String?>(value: nil)
    
    let navigationEventRelay = PublishRelay<NavigationEventExchangeDetails>()
    
    init() {
        input = Input(actionButtonTapped: actionButtonTappedRelay)
        output = Output(
            navigationEvent: navigationEventRelay.asSignal(),
            exchangeName: exchangeNameRelay.asDriver(),
            exchangeWebsite: exchangeWebsiteRelay.asDriver(),
            volume1Day: volume1DayRelay.asDriver(),
            dataSymbolsCount: dataSymbolsCountRelay.asDriver(),
            dataPeriod: dataPeriodRelay.asDriver(),
            exchangeIconURL: exchangeIconURLRelay.asDriver()
        )
    }
    
    struct Input: ExchangeDetailsViewModelInput {
        var actionButtonTapped: PublishRelay<Void>
    }
    
    struct Output: ExchangeDetailsViewModelOutput {
        var navigationEvent: Signal<NavigationEventExchangeDetails>
        var exchangeName: Driver<String?>
        var exchangeWebsite: Driver<String?>
        var volume1Day: Driver<String?>
        var dataSymbolsCount: Driver<String?>
        var dataPeriod: Driver<String?>
        var exchangeIconURL: Driver<String?>
    }
}
