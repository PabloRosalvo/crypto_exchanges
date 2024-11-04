import RxSwift
import RxCocoa
import crypto_exchanges

class MockHomeViewModel: HomeViewModelType {
    var primaryButtonTappedRelay = PublishRelay<Void>()
    var titleTextRelay = BehaviorRelay<String>(value: "Mock Title")
    var descriptionTextRelay = BehaviorRelay<String>(value: "Mock Description")
    var navigationEventRelay = PublishRelay<NavigationEventExchangeHome>()
    
    private let disposeBag = DisposeBag()
    
    var input: HomeViewModelInput {
        return Input(primaryButtonTapped: primaryButtonTappedRelay)
    }
    
    var output: HomeViewModelOutput {
        return Output(
            navigationEventRelay: navigationEventRelay,
            titleTextRelay: titleTextRelay,
            descriptionTextRelay: descriptionTextRelay
        )
    }
    
    init() {
        primaryButtonTappedRelay
            .map { NavigationEventExchangeHome.goToListExchange }
            .bind(to: navigationEventRelay)
            .disposed(by: disposeBag)
    }
    
    struct Input: HomeViewModelInput {
        var primaryButtonTapped: PublishRelay<Void>
    }
    
    struct Output: HomeViewModelOutput {
        private let navigationEventRelay: PublishRelay<NavigationEventExchangeHome>
        private let titleTextRelay: BehaviorRelay<String>
        private let descriptionTextRelay: BehaviorRelay<String>
        
        init(navigationEventRelay: PublishRelay<NavigationEventExchangeHome>, titleTextRelay: BehaviorRelay<String>, descriptionTextRelay: BehaviorRelay<String>) {
            self.navigationEventRelay = navigationEventRelay
            self.titleTextRelay = titleTextRelay
            self.descriptionTextRelay = descriptionTextRelay
        }
        
        var navigationEvent: Signal<NavigationEventExchangeHome> {
            return navigationEventRelay.asSignal(onErrorSignalWith: .empty())
        }
        
        var titleText: Driver<String> {
            return titleTextRelay.asDriver()
        }
        
        var descriptionText: Driver<String> {
            return descriptionTextRelay.asDriver()
        }
    }
}
