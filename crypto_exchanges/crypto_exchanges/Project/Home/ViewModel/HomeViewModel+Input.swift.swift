import RxSwift
import RxCocoa

extension HomeViewModel {
    struct Input: HomeViewModelInput {
        let primaryButtonTapped: PublishRelay<Void>
        
        init(primaryButtonRelay: PublishRelay<Void>) {
            self.primaryButtonTapped = primaryButtonRelay
        }
    }
}
