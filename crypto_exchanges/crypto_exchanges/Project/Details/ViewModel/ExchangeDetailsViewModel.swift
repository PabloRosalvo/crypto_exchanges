import RxSwift
import RxCocoa

// MARK: - Protocols

public protocol ExchangeDetailsViewModelInput {
    var actionButtonTapped: PublishRelay<Void> { get }
}

public protocol ExchangeDetailsViewModelOutput {
    var exchangeName: Driver<String?> { get }
    var exchangeWebsite: Driver<String?> { get }
    var volume1Day: Driver<String?> { get }
    var dataSymbolsCount: Driver<String?> { get }
    var dataPeriod: Driver<String?> { get }
    var exchangeIconURL: Driver<String?> { get }
    var navigationEvent: Signal<NavigationEventExchangeDetails> { get }
}

public protocol ExchangeDetailsViewModelType {
    var input: ExchangeDetailsViewModelInput { get }
    var output: ExchangeDetailsViewModelOutput { get }
}


class ExchangeDetailsViewModel: ExchangeDetailsViewModelType {
    
    private let actionButtonRelay = PublishRelay<Void>()
    private let navigationRelay = PublishRelay<NavigationEventExchangeDetails>()

    private let exchangeNameRelay = BehaviorRelay<String?>(value: nil)
    private let exchangeWebsiteRelay = BehaviorRelay<String?>(value: nil)
    private let volume1DayRelay = BehaviorRelay<String?>(value: nil)
    private let dataSymbolsCountRelay = BehaviorRelay<String?>(value: nil)
    private let dataPeriodRelay = BehaviorRelay<String?>(value: nil)
    private let exchangeIconURLRelay = BehaviorRelay<String?>(value: nil)
    
    private let exchangeDetailsRelay = BehaviorRelay<ExchangeDetails?>(value: nil)
    
    private let disposeBag = DisposeBag()
    
    var input: ExchangeDetailsViewModelInput { return Input(actionButtonRelay: actionButtonRelay) }
    var output: ExchangeDetailsViewModelOutput { return Output(
        exchangeNameRelay: exchangeNameRelay,
        exchangeWebsiteRelay: exchangeWebsiteRelay,
        volume1DayRelay: volume1DayRelay,
        dataSymbolsCountRelay: dataSymbolsCountRelay,
        dataPeriodRelay: dataPeriodRelay,
        exchangeIconURLRelay: exchangeIconURLRelay,
        navigationEvent: navigationRelay.asSignal()
    )}
    
    init(detailsObservable: Observable<ExchangeDetails>) {
        bindInputs()
        bindDetails(detailsObservable: detailsObservable)
    }
    
    private func bindInputs() {
        actionButtonRelay
            .withLatestFrom(exchangeWebsiteRelay)
            .compactMap { $0 }
            .map { urlString in
                return NavigationEventExchangeDetails.goToWebsite(url: URL(string: urlString)!)
            }
            .bind(to: navigationRelay)
            .disposed(by: disposeBag)
    }
    
    
    private func bindDetails(detailsObservable: Observable<ExchangeDetails>) {
        detailsObservable
            .subscribe(onNext: { [weak self] details in
                self?.updateUI(details: details)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(details: ExchangeDetails) {
        exchangeNameRelay.accept(details.exchange.name)
        exchangeWebsiteRelay.accept(details.exchange.website)
        volume1DayRelay.accept("Volume (1 Day USD): \(details.exchange.volume1DayUSD ?? 0)")
        dataSymbolsCountRelay.accept("Symbols Count: \(details.exchange.dataSymbolsCount ?? 0)")
        if let start = details.exchange.dataTradeStart, let end = details.exchange.dataTradeEnd {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dataPeriodRelay.accept("Data Period: \(dateFormatter.string(from: start)) - \(dateFormatter.string(from: end))")
        }
        exchangeIconURLRelay.accept(details.icon?.url)
    }
}

extension ExchangeDetailsViewModel {
    struct Input: ExchangeDetailsViewModelInput {
        let actionButtonTapped: PublishRelay<Void>
        
        init(actionButtonRelay: PublishRelay<Void>) {
            self.actionButtonTapped = actionButtonRelay
        }
    }
}

extension ExchangeDetailsViewModel {
    struct Output: ExchangeDetailsViewModelOutput {
        let exchangeName: Driver<String?>
        let exchangeWebsite: Driver<String?>
        let volume1Day: Driver<String?>
        let dataSymbolsCount: Driver<String?>
        let dataPeriod: Driver<String?>
        let exchangeIconURL: Driver<String?>
        let navigationEvent: Signal<NavigationEventExchangeDetails>

        init(
            exchangeNameRelay: BehaviorRelay<String?>,
            exchangeWebsiteRelay: BehaviorRelay<String?>,
            volume1DayRelay: BehaviorRelay<String?>,
            dataSymbolsCountRelay: BehaviorRelay<String?>,
            dataPeriodRelay: BehaviorRelay<String?>,
            exchangeIconURLRelay: BehaviorRelay<String?>,
            navigationEvent: Signal<NavigationEventExchangeDetails> // Recebe o Signal aqui
        ) {
            self.exchangeName = exchangeNameRelay.asDriver()
            self.exchangeWebsite = exchangeWebsiteRelay.asDriver()
            self.volume1Day = volume1DayRelay.asDriver()
            self.dataSymbolsCount = dataSymbolsCountRelay.asDriver()
            self.dataPeriod = dataPeriodRelay.asDriver()
            self.exchangeIconURL = exchangeIconURLRelay.asDriver()
            self.navigationEvent = navigationEvent // Já é um Signal, não precisa de conversão
        }
    }
}
