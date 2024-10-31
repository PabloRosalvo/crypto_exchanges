import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.actionButtonTapped = { [weak self] in
            self?.goToHome()
        }
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
        parentCoordinator?.childCoordinators.append(self)
    }
    
    func goToHome() {

    }
    
    func goToListFlight() {

    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
