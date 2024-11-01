import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, ViewConfiguration {
    let viewModel: HomeViewModelType
    let disposeBag = DisposeBag()
    
    private lazy var contentView: HomeView = {
        return HomeView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        self.view.backgroundColor = UIColor.customBackground
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        self.navigationController?.navigationBar.tintColor = UIColor.customApp
    }
    
}

extension HomeViewController {
    private func bind() {
        contentView.actionButtonTapped
            .bind(to: viewModel.input.primaryButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.output.titleText
            .drive(contentView.titleText)
            .disposed(by: disposeBag)
        
        viewModel.output.descriptionText
            .drive(contentView.descriptionText)
            .disposed(by: disposeBag)
    }
}
