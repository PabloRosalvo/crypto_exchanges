import UIKit
import Kingfisher

class ExchangeCell: UITableViewCell, Reusable {
    
    private let exchangeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    private let exchangeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let exchangeIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    private let dailyVolumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let trustIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    private let trustSealLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.systemGreen
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exchangeInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [exchangeNameLabel, exchangeIdLabel, dailyVolumeLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var trustStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trustIconImageView, trustSealLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [exchangeIconImageView, exchangeInfoStack])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var overallStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainStackView, trustStackView , detailsLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.customBackground
    }
    
    private func addHierarchy() {
        contentView.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            overallStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            overallStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overallStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            overallStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
 
    func updateCell(model: Exchange,
                    icon: ExchangeIcon) {
        exchangeNameLabel.text = model.name
        exchangeIdLabel.text = "ID: \(model.exchangeID ?? "")"
        dailyVolumeLabel.text = "Volume Diário em USD: \(model.volume1DayUSD?.formatAsUSNumber() ?? "")"
        detailsLabel.text = "Sabia mais detalhes da exchange"
        
        let trustRank = TrustRank(from: model.rank ?? 0)
        trustIconImageView.image = UIImage(systemName: trustRank.icon)
        trustSealLabel.text = trustRank.message
        trustSealLabel.textColor = trustRank.color
        
        let placeholder = UIImage(named: "loading-placeholder")
        exchangeIconImageView.setImage(from: icon.url,
                                       placeholder: placeholder)

     }
}
