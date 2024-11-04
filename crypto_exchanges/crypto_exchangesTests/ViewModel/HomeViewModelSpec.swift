import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import crypto_exchanges

class HomeViewModelSpec: QuickSpec {
    override class func spec() {
        describe("HomeViewModel") {
            var viewModel: HomeViewModel!
            var disposeBag: DisposeBag!
            
            beforeEach {
                viewModel = HomeViewModel()
                disposeBag = DisposeBag()
            }
            
            afterEach {
                disposeBag = nil
            }
            
            context("when initialized") {
                it("should have the correct initial title and description") {
                    var receivedTitle: String?
                    var receivedDescription: String?
                    
                    viewModel.output.titleText
                        .drive(onNext: { title in
                            receivedTitle = title
                        })
                        .disposed(by: disposeBag)
                    
                    viewModel.output.descriptionText
                        .drive(onNext: { description in
                            receivedDescription = description
                        })
                        .disposed(by: disposeBag)
                    
                    expect(receivedTitle).toEventually(equal(LocalizedString.titleHome.localized))
                    expect(receivedDescription).toEventually(equal(LocalizedString.descripitionHome.localized))
                }
            }
            
            context("when primary button is tapped") {
                it("should trigger navigation event") {
                    var receivedNavigationEvent: NavigationEventExchangeHome?
                    
                    viewModel.output.navigationEvent
                        .emit(onNext: { event in
                            receivedNavigationEvent = event
                        })
                        .disposed(by: disposeBag)
                    
                    viewModel.input.primaryButtonTapped.accept(())
                    
                    expect(receivedNavigationEvent).toEventually(equal(.goToListExchange))
                }
            }
        }
    }
}
