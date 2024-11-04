//
//  ExchangeDetailsCoordinator.swift
//  crypto_exchanges
//
//  Created by Pablo Rosalvo de Melo Lopes on 04/11/24.
//
import UIKit
import RxSwift

class ExchangeDetailsCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with exchangeDetails: Observable<ExchangeDetails>) {
        let viewModel = ExchangeDetailsViewModel(
            detailsObservable: exchangeDetails
        )
        
        viewModel.output.navigationEvent
            .emit(onNext: { [weak self] event in
                self?.handleNavigation(event: event)
            })
            .disposed(by: disposeBag)
        let exchangeDetailsViewController = ExchangeDetailsFactory.makeExchangeDetailsViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: exchangeDetailsViewController)
        navigationController.modalPresentationStyle = .formSheet
        if let window = UIApplication.shared.windows.first {
            window.rootViewController?.present(navigationController, animated: true)
        }
    }

    func handleNavigation(event: NavigationEventExchangeDetails) {
        switch event {
        case .goToWebsite(let url):
            openWebsite(url)
        }
    }
    
    func openWebsite(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

