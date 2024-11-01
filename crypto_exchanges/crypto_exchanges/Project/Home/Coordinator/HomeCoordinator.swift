import UIKit
import RxSwift

protocol HomeCoordinatorProtocol: AnyObject {
    func handleNavigation(event: NavigationEvent)
}

class HomeCoordinator: HomeCoordinatorProtocol, Coordinator {
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
    
    func handleNavigation(event: NavigationEvent) {
        switch event {
        case .goToListExchange:
            print("Navigating to ListExchange")
        }
    }
}
