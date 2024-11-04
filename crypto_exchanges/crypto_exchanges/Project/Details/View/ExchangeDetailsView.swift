import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class ExchangeDetailsView: UIView {
    let exchangeNameRelay = BehaviorRelay<String?>(value: nil)
    let exchangeWebsiteRelay = BehaviorRelay<String?>(value: nil)
    let volume1DayRelay = BehaviorRelay<String?>(value: nil)
    let dataSymbolsCountRelay = BehaviorRelay<String?>(value: nil)
    let dataPeriodRelay = BehaviorRelay<String?>(value: nil)
    let exchangeIconURLRelay = BehaviorRelay<String?>(value: nil)
    let actionButtonTapped = PublishRelay<Void>()
    
    let disposeBag = DisposeBag()
    
    let exchangeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }()
    
    let exchangeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        return label
    }()
    
    let exchangeWebsiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let volume1DayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let dataSymbolsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let dataPeriodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var actionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Acessar o site", for: .normal)
        button.backgroundColor = UIColor.customBackground
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            exchangeIconImageView,
            exchangeNameLabel,
            exchangeWebsiteButton,
            volume1DayLabel,
            dataSymbolsCountLabel,
            dataPeriodLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(mainStackView)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: actionButton.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupBindings() {
        exchangeNameRelay
            .bind(to: exchangeNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        exchangeWebsiteRelay
            .bind(to: exchangeWebsiteButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        volume1DayRelay
            .bind(to: volume1DayLabel.rx.text)
            .disposed(by: disposeBag)
        
        dataSymbolsCountRelay
            .bind(to: dataSymbolsCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        dataPeriodRelay
            .bind(to: dataPeriodLabel.rx.text)
            .disposed(by: disposeBag)
        
        exchangeIconURLRelay
            .subscribe(onNext: { [weak self] urlString in
                guard let urlString = urlString, let url = URL(string: urlString) else { return }
                let placeholder = UIImage(named: "loading-placeholder")
                self?.exchangeIconImageView.kf.setImage(with: url, placeholder: placeholder)
            })
            .disposed(by: disposeBag)
        
        actionButton.rx.tap
            .bind(to: actionButtonTapped)
            .disposed(by: disposeBag)
    }
}
