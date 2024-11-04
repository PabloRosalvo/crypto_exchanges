import RxSwift
import RxCocoa

extension ExchangeViewModel {
    struct Output: ExchangeViewModelOutput {
        var exchangesWithIcons:  Driver<[(Exchange, ExchangeIcon?)]>
        var error: Driver<String>
        var filterOptions: Driver<[String]>
        let navigationEvent: Signal<NavigationEventExchangeList>

        init(exchangesWithIcons: Driver<[(Exchange, ExchangeIcon?)]>,
             filterOptions: Driver<[String]>,
             navigationEvent: Signal<NavigationEventExchangeList>,
             error: Driver<String>) {
            self.exchangesWithIcons = exchangesWithIcons
            self.filterOptions = filterOptions
            self.navigationEvent = navigationEvent
            self.error = error
        }
    }
}

