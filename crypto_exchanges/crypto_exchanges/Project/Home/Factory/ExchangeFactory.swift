import Foundation

class ExchangeFactory {
    static func makeExchangeViewController(viewModel: ExchangeViewModelType) -> ExchangeViewController {
        return ExchangeViewController(viewModel: viewModel)
    }
}
