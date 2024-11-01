import UIKit
import RxSwift
import RxCocoa

final class HomeView: UIView {
    
    let actionButtonTapped = PublishRelay<Void>()
    let titleText = BehaviorRelay<String?>(value: nil)
    let descriptionText = BehaviorRelay<String?>(value: nil)
    
    private let disposeBag = DisposeBag()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = UIColor.customApp
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.customApp
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var actionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LocalizedString.titleButtonHome.localized, for: .normal)
        button.backgroundColor = UIColor.customBackground
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        setupBindings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
        setupConstraints()
    }
    
    private func setupBindings() {
        actionButton.rx.tap
            .bind(to: actionButtonTapped)
            .disposed(by: disposeBag)
        
        titleText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        descriptionText
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 200),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 48),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -48),
        
            actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -54),
            actionButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}
