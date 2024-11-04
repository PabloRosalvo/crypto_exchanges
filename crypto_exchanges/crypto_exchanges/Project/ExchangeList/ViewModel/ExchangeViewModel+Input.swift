import RxSwift
import RxCocoa

extension ExchangeViewModel {
    struct Input: ExchangeViewModelInput {
        let searchTextRelay: BehaviorRelay<String?>
        let selectedIndexRelay: PublishRelay<Int>
        let filterSwitchRelay: BehaviorRelay<Set<Int>>
        
        init(searchTextRelay: BehaviorRelay<String?>, selectedIndexRelay: PublishRelay<Int>, filterSwitchRelay: BehaviorRelay<Set<Int>>) {
            self.searchTextRelay = searchTextRelay
            self.selectedIndexRelay = selectedIndexRelay
            self.filterSwitchRelay = filterSwitchRelay
        }
    }
}
