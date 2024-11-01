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
        label.numberOfLines = 1
        return label
    }()
    
    private let exchangeIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
        return label
    }()

    private let dailyVolumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let trustSealLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.systemGreen
        label.numberOfLines = 1
        return label
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Veja detalhes da exchange", for: .normal)
        return button
    }()
    
    private lazy var exchangeInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [exchangeNameLabel, exchangeIdLabel, dailyVolumeLabel, trustSealLabel])
        stackView.axis = .vertical
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
        let stackView = UIStackView(arrangedSubviews: [mainStackView, detailsButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addHierarchy()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
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
            overallStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    private func setupActions() {
        detailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
    }
    
    @objc private func showDetails() {
        print("Mais detalhes...")
    }
    
    func updateCell(model: Exchange) {
        exchangeNameLabel.text = model.name
        exchangeIdLabel.text = "ID: \(model.exchangeID)"
        dailyVolumeLabel.text = "Volume Diário em USD: \(model.volume1DayUSD)"
        trustSealLabel.text = "Selo de Confiança: \(model.rank)"
        let iconUrlString = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/32a3ccb439ba4d20b995fd61194c5e18.png"
        exchangeIconImageView.setImage(from: iconUrlString, forceRefresh: false)
    }

}
