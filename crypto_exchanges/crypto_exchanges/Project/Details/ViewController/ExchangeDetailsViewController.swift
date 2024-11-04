import UIKit
import RxSwift
import RxCocoa

final class ExchangeDetailsViewController: UIViewController {
    
    private let viewModel: ExchangeDetailsViewModelType
    private let disposeBag = DisposeBag()
    
    private let contentView = ExchangeDetailsView()
    
    init(viewModel: ExchangeDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bind()
    }
    
    func configureViews() {
        self.view.backgroundColor = UIColor.customBackground
        self.navigationItem.title = "Exchanges"
        
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        closeButton.tintColor = UIColor.customApp
        
        self.navigationItem.leftBarButtonItem = closeButton
    }

    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func bind() {
        viewModel.output.exchangeName
            .drive(contentView.exchangeNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.exchangeWebsite
            .drive(contentView.exchangeWebsiteButton.rx.title(for: .normal))
            .disposed(by: disposeBag)

        viewModel.output.volume1Day
            .drive(contentView.volume1DayLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.dataSymbolsCount
            .drive(contentView.dataSymbolsCountLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.dataPeriod
            .drive(contentView.dataPeriodLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.exchangeIconURL
            .drive(onNext: { [weak self] urlString in
                guard let urlString = urlString, let url = URL(string: urlString) else { return }
                let placeholder = UIImage(named: "loading-placeholder")
                self?.contentView.exchangeIconImageView.kf.setImage(with: url, placeholder: placeholder)
            })
            .disposed(by: disposeBag)

        contentView.actionButtonTapped
            .bind(to: viewModel.input.actionButtonTapped)
            .disposed(by: disposeBag)
    }
}
