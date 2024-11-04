import UIKit
import Kingfisher

class ExchangeDetailsView: UIView {
    
    private let exchangeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }()
    
    // Exchange Name
    private let exchangeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let exchangeWebsiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        return button
    }()
    
    // Volume (1 Day USD)
    private let volume1DayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    // Data Symbols Count
    private let dataSymbolsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    // Data Period (Start and End)
    private let dataPeriodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    // StackView for layout
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            exchangeIconImageView,
            exchangeNameLabel,
            exchangeWebsiteButton,
            volume1DayLabel,
            dataSymbolsCountLabel,
            dataPeriodLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func updateView(with details: ExchangeDetails) {
        exchangeNameLabel.text = details.exchange.name
        exchangeWebsiteButton.setTitle("Acessar o site Oficial", for: .normal)
        volume1DayLabel.text = "Volume (1 Day USD): \(details.exchange.volume1DayUSD ?? 0)"
        dataSymbolsCountLabel.text = "Symbols Count: \(details.exchange.dataSymbolsCount ?? 0)"
        
        if let start = details.exchange.dataTradeStart, let end = details.exchange.dataTradeEnd {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dataPeriodLabel.text = "Data Period: \(dateFormatter.string(from: start)) - \(dateFormatter.string(from: end))"
        }
        
        if let iconUrl = details.icon?.url {
            let placeholder = UIImage(named: "loading-placeholder")
            exchangeIconImageView.kf.setImage(with: URL(string: iconUrl), placeholder: placeholder)
        }
    }
    
    @objc private func openWebsite() {
        if let website = exchangeWebsiteButton.title(for: .normal), let url = URL(string: website) {
            UIApplication.shared.open(url)
        }
    }
}
