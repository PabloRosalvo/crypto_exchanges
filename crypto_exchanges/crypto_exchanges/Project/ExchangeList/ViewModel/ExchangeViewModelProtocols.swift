import RxSwift
import RxCocoa

protocol ExchangeViewModelInput {
    var searchTextRelay: BehaviorRelay<String?> { get }
    var selectedIndexRelay: PublishRelay<Int> { get }
    var filterSwitchRelay: BehaviorRelay<Set<Int>> { get }
    
}

protocol ExchangeViewModelOutput {
    var exchangesWithIcons: Driver<[(Exchange, ExchangeIcon?)]> { get }
    var filterOptions: Driver<[String]> { get }
    var error: Driver<String> { get }
    var navigationEvent: Signal<NavigationEventExchangeList> { get }
    var isLoading: Driver<Bool> { get }
}


protocol ExchangeViewModelType {
    var input: ExchangeViewModelInput { get }
    var output: ExchangeViewModelOutput { get }
}
