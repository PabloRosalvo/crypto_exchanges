import UIKit
import RxSwift
import RxCocoa

class ExchangeViewController: UIViewController, ViewConfiguration {
    
    private let viewModel: ExchangeViewModelType
    let disposeBag = DisposeBag()
    
    private lazy var contentView: ExchangeView = {
        return ExchangeView()
    }()
    
    init(viewModel: ExchangeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
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
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
extension ExchangeViewController {
    private func bind() {
        contentView.tableView.dataSource = nil
        contentView.tableView.delegate = nil
        
        contentView.searchBarTextRelay
            .bind(to: viewModel.input.searchTextRelay)
            .disposed(by: disposeBag)
        
        contentView.selectedIndexRelay
            .bind(to: viewModel.input.selectedIndexRelay)
            .disposed(by: disposeBag)
        
        viewModel.output.exchangesWithIcons
            .drive(contentView.tableView.rx.items(cellIdentifier: ExchangeCell.reuseIdentifier,
                                                  cellType: ExchangeCell.self)) { _, model, cell in
                let (exchange, icon) = model
                guard let iconToUse = icon else { return }
                cell.updateCell(model: exchange, icon: iconToUse)
            }.disposed(by: disposeBag)
        
        contentView.switchStateRelay
            .bind(to: viewModel.input.filterSwitchRelay)
            .disposed(by: disposeBag)
        
        viewModel.output.filterOptions
            .drive(onNext: { [weak self] options in
                self?.contentView.bindFilterOptions(options)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .drive(onNext: { [weak self] errorMessage in
                guard !errorMessage.isEmpty else { return }
                self?.showErrorAlert(message: errorMessage)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .drive(onNext: { [weak self] isLoading in
                if isLoading {
                    LoadingView.startLoading(in: self?.view ?? UIView())
                } else {
                    LoadingView.stopLoading()
                }
            })
            .disposed(by: disposeBag)
    }
}
