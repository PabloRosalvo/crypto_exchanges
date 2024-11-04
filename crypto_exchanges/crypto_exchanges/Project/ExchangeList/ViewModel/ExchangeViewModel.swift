import RxSwift
import RxCocoa

class ExchangeViewModel: ExchangeViewModelType {
    private let disposeBag = DisposeBag()
    private let exchangesRelay = BehaviorRelay<[Exchange]>(value: [])
    private let iconsRelay = BehaviorRelay<[ExchangeIcon]>(value: [])
    private let filterSwitchRelay = BehaviorRelay<Set<Int>>(value: [])
    private let searchTextRelay = BehaviorRelay<String?>(value: "")
    private let selectedIndexRelay = PublishRelay<Int>()
    private let errorRelay = PublishRelay<String>()
    private let navigationRelay = PublishRelay<NavigationEventExchangeList>()

    var input: ExchangeViewModelInput {
        return Input(searchTextRelay: searchTextRelay,
                     selectedIndexRelay: selectedIndexRelay,
                     filterSwitchRelay: filterSwitchRelay)
    }
    
    var output: ExchangeViewModelOutput {
        return Output(
            exchangesWithIcons: createExchangesWithIcons(),
            filterOptions: createFilterOptions(),
            navigationEvent: navigationRelay.asSignal(onErrorSignalWith: .empty()),
            error: errorRelay.asDriver(onErrorJustReturn: "")
        )
    }
    
    private let apiService: ExchangeAPIProtocol
    
    init(apiService: ExchangeAPIProtocol) {
        self.apiService = apiService
        self.fetchExchanges()
        bindInputs()
    }
    
    private func bindInputs() {
        selectedIndexRelay
            .withLatestFrom(createExchangesWithIcons()) { index, exchangesWithIcons in
                let (exchange, icon) = exchangesWithIcons[index]

                let exchangeDetailsDTO = ExchangeDetails(
                    exchange: exchange,
                    icon: icon
                )
                return NavigationEventExchangeList.goToListExchange(exchangeDetailsDTO)
            }
            .bind(to: navigationRelay)
            .disposed(by: disposeBag)
    }
    
    private func createExchangesWithIcons() -> Driver<[(Exchange, ExchangeIcon?)]> {
        return Driver.combineLatest(
            createFilteredAndSearchedExchanges(),
            iconsRelay.asDriver()
        )
        .map { exchanges, icons in
            return exchanges.map { exchange in
                let icon = icons.first { $0.exchangeID == exchange.exchangeID }
                return (exchange, icon)
            }
        }
    }
    
    private func fetchExchanges() {
        apiService.fetchExchanges()
            .asObservable()
            .flatMap { [weak self] exchanges -> Observable<([Exchange], [ExchangeIcon])> in
                guard let self = self else { return Observable.just(([], [])) }
                return self.apiService.fetchExchangeIcons()
                    .asObservable()
                    .map { icons in (exchanges, icons) }
            }
            .catch { [weak self] error in
                self?.handleError(error)
                return Observable.just(([], []))
            }
            .subscribe(onNext: { [weak self] exchanges, icons in
                self?.exchangesRelay.accept(exchanges)
                self?.iconsRelay.accept(icons)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleError(_ error: Error) {
        let errorMessage = error.localizedDescription
        errorRelay.accept(errorMessage)
    }
    
    private func createFilteredAndSearchedExchanges() -> Driver<[Exchange]> {
        return Driver.combineLatest(
            exchangesRelay.asDriver(),
            filterSwitchRelay.asDriver(),
            searchTextRelay.asDriver(onErrorJustReturn: nil)
        )
        .map { [weak self] exchangesList, activeFilters, searchText in
            guard let self = self else { return [] }
            var filteredExchanges = self.filterExchanges(exchangesList, withFilters: activeFilters)
            filteredExchanges = self.searchExchanges(filteredExchanges, withSearchText: searchText)
            return self.sortExchanges(filteredExchanges)
        }
    }
    
    private func filterExchanges(_ exchanges: [Exchange], withFilters filters: Set<Int>) -> [Exchange] {
        if filters.isEmpty {
            return exchanges.filter { $0.rank == 1 }
        }
        return exchanges.filter { exchange in
            (filters.contains(0) && exchange.rank == 1) ||
            (filters.contains(1) && exchange.rank == 2) ||
            (filters.contains(2) && (exchange.rank ?? 0) < 1)
        }
    }
    
    private func searchExchanges(_ exchanges: [Exchange], withSearchText searchText: String?) -> [Exchange] {
        guard let searchText = searchText, !searchText.isEmpty else {
            return exchanges
        }
        return exchanges.filter { exchange in
            exchange.name?.lowercased().contains(searchText.lowercased()) ?? false ||
            exchange.exchangeID?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    private func sortExchanges(_ exchanges: [Exchange]) -> [Exchange] {
        return exchanges.sorted { ($0.rank ?? 0) < ($1.rank ?? 0) }
    }
    
    private func createFilterOptions() -> Driver<[String]> {
        let filterOptions = ["Alta Confiabilidade (Rank 1)", "Média Confiabilidade (Rank 2)", "Baixa Confiabilidade"]
        return Driver.just(filterOptions)
    }
}
