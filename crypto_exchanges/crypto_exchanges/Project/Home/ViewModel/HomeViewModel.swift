import RxSwift
import RxCocoa

public protocol HomeViewModelInput {
    var primaryButtonTapped: PublishRelay<Void> { get }
}

public protocol HomeViewModelOutput {
    var titleText: Driver<String> { get }
    var descriptionText: Driver<String> { get }
    var navigationEvent: Signal<NavigationEventExchangeHome> { get }
}

public protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

class HomeViewModel: HomeViewModelType {
    
    private let primaryButtonRelay = PublishRelay<Void>()
    private let navigationRelay = PublishRelay<NavigationEventExchangeHome>()
    
    private let titleTextRelay = BehaviorRelay<String>(value: LocalizedString.titleHome.localized)
    private let descriptionTextRelay = BehaviorRelay<String>(value: LocalizedString.descripitionHome.localized)
    
    private let disposeBag = DisposeBag()
    
    var input: HomeViewModelInput { return Input(primaryButtonRelay: primaryButtonRelay) }
    var output: HomeViewModelOutput { return Output(navigationEventRelay: navigationRelay,
                                                    titleTextRelay: titleTextRelay,
                                                    descriptionTextRelay: descriptionTextRelay) }
    init() {
        bindInputs()
    }
    
    private func bindInputs() {
        primaryButtonRelay
            .map { NavigationEventExchangeHome.goToListExchange }
            .bind(to: navigationRelay)
            .disposed(by: disposeBag)
    }
}
