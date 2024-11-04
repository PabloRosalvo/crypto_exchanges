import Nimble
import Nimble_Snapshots
import Quick
import RxSwift

@testable import crypto_exchanges

final class HomeViewControllerSpec: QuickSpec {
    override class func spec() {
        describe("HomeViewController") {
            var sut: HomeViewController!
            var mockViewModel: MockHomeViewModel!
            var disposeBag: DisposeBag!
                
            beforeEach {
                disposeBag = DisposeBag()
                mockViewModel = MockHomeViewModel()
                sut = HomeViewController(viewModel: mockViewModel)
                
                WindowHelper.showInTestWindow(viewController: sut)
            }
            
            afterEach {
                WindowHelper.cleanTestWindow()
                disposeBag = nil
            }
            
            it("should display the correct title and description") {
                expect(sut).toEventually(haveValidSnapshot())
            }
            
            it("should trigger navigation event on button tap") {
                var emittedEvent: NavigationEventExchangeHome? = nil
                
                 mockViewModel.output.navigationEvent
                    .emit(onNext: { event in
                        emittedEvent = event
                    })
                    .disposed(by: disposeBag)
                
                mockViewModel.input.primaryButtonTapped.accept(())
                
                expect(emittedEvent).toEventually(equal(.goToListExchange), timeout: .seconds(2))
            }
        }
    }
}
