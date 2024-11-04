import UIKit
import RxSwift

class ExchangeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = ExchangeAPI()
        let viewModel = ExchangeViewModel(apiService: service)
        
        viewModel.output.navigationEvent
            .emit(onNext: { [weak self] event in
                self?.handleNavigation(event: event)
            })
            .disposed(by: disposeBag)
        
        let exchangeViewController = ExchangeFactory.makeExchangeViewController(viewModel: viewModel)
        navigationController.pushViewController(exchangeViewController, animated: true)
    }
    
    func handleNavigation(event: NavigationEventExchangeList) {
        switch event {
        case .goToListExchange(let model):
            print(model.exchange)
        }
    }
}
