import RxSwift
import RxCocoa

extension HomeViewModel {
    struct Output: HomeViewModelOutput {
        let titleText: Driver<String>
        let descriptionText: Driver<String>
        let navigationEvent: Signal<NavigationEvent>
        
        init(navigationEventRelay: PublishRelay<NavigationEvent>,
             titleTextRelay: BehaviorRelay<String>,
             descriptionTextRelay: BehaviorRelay<String>) {
            self.navigationEvent = navigationEventRelay.asSignal()
            self.titleText = titleTextRelay.asDriver()
            self.descriptionText = descriptionTextRelay.asDriver()
        }
    }
}
