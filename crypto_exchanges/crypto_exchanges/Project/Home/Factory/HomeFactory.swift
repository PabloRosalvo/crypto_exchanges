import Foundation

class HomeFactory {
    static func makeHomeViewController(viewModel: HomeViewModelType) -> HomeViewController {
        return HomeViewController(viewModel: viewModel)
    }
}
