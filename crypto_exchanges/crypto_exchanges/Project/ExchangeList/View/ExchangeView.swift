import UIKit
import RxSwift
import RxCocoa

final class ExchangeView: UIView {
    
    let searchBarTextRelay = BehaviorRelay<String?>(value: nil)
    let switchStateRelay = PublishRelay<(Int, Bool)>()
    let selectedIndexRelay = PublishRelay<Int>()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExchangeCell.self)
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Exchanges"
        return searchBar
    }()
    
    private var listModel = BehaviorRelay<[Exchange]>(value: [])
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.customBackground
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        addSubview(searchBar)
        addSubview(filterStackView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            filterStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            filterStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: filterStackView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        searchBar.rx.text
            .bind(to: searchBarTextRelay)
            .disposed(by: disposeBag)
        
        listModel
            .bind(to: tableView.rx.items(
                cellIdentifier: ExchangeCell.reuseIdentifier,
                cellType: ExchangeCell.self))
        { _, model, cell in
            cell.updateCell(model: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: selectedIndexRelay)
            .disposed(by: disposeBag)
    }
    
    func bindFilterOptions(_ serviceTypes: [String]) {
        createFilterSwitches(for: serviceTypes)
    }
    
    func loadModel(_ list: [Exchange]) {
        listModel.accept(list)
    }
    
    private func createFilterSwitches(for serviceTypes: [String]) {
        filterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, serviceType) in serviceTypes.enumerated() {
            let switchControl = createSwitchControl(tag: index)
            let label = createLabel(withText: serviceType)
            
            let hStack = UIStackView(arrangedSubviews: [switchControl, label])
            hStack.axis = .horizontal
            hStack.spacing = 10
            filterStackView.addArrangedSubview(hStack)
        }
    }
    
    private func createSwitchControl(tag: Int) -> UISwitch {
        let switchControl = UISwitch()
        switchControl.tag = tag
        switchControl.isOn = false
        switchControl.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return switchControl
    }
    
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        switchStateRelay.accept((sender.tag, sender.isOn))
    }
}
