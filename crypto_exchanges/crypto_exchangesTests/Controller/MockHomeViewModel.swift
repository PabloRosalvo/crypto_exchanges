import RxSwift
import RxCocoa
import crypto_exchanges
import RxSwift

class MockHomeViewModel: HomeViewModelType {
    let primaryButtonTapped = PublishRelay<Void>()
    private let navigationRelay = PublishRelay<NavigationEvent>()
    
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
    
    private let titleTextRelay = BehaviorRelay<String>(value: "Mock Title")
    private let descriptionTextRelay = BehaviorRelay<String>(value: "Mock Description")
    
    private let disposeBag = DisposeBag()
    
    init() {
        primaryButtonTapped
            .map { NavigationEvent.goToListExchange }
            .bind(to: navigationRelay)
            .disposed(by: disposeBag)
    }
}

extension MockHomeViewModel: HomeViewModelInput, HomeViewModelOutput {
    var navigationEvent: Signal<NavigationEvent> {
        return navigationRelay.asSignal(onErrorSignalWith: .empty())
    }
    
    var titleText: Driver<String> {
        return titleTextRelay.asDriver()
    }
    
    var descriptionText: Driver<String> {
        return descriptionTextRelay.asDriver()
    }
}

