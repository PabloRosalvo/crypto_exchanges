import UIKit
import RxSwift

class HomeCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let homeViewController = HomeFactory.makeHomeViewController(viewModel: viewModel)
        
        viewModel.output.navigationEvent
            .emit(onNext: { [weak self] event in
                self?.handleNavigation(event: event)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func handleNavigation(event: NavigationEventExchangeHome) {
        switch event {
        case .goToListExchange:
            let exchangeCoordinator = ExchangeCoordinator(navigationController: navigationController)
            childCoordinators.append(exchangeCoordinator)
            exchangeCoordinator.start()
        }
    }
}
