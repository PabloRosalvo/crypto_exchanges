import UIKit

class ExchangeDetailsFactory {
    static func makeExchangeDetailsViewController(viewModel: ExchangeDetailsViewModelType) -> ExchangeDetailsViewController {
        return ExchangeDetailsViewController(viewModel: viewModel)
    }
}
