import Quick
import Nimble
import Nimble_Snapshots
import RxSwift

@testable import crypto_exchanges

final class HomeViewSpec: QuickSpec {
    override class func spec() {
        describe("HomeView") {
            var sut: HomeView!
            var disposeBag: DisposeBag!
            
            beforeEach {
                sut = HomeView()
                disposeBag = DisposeBag()
                
                sut.titleText.accept("Test Title")
                sut.descriptionText.accept("This is a test description for the HomeView.")
            }
            
            afterEach {
                disposeBag = nil
            }
            
            context("when action button is tapped") {
                it("should emit an event on actionButtonTapped") {
                    var actionTriggered = false
                    
                    sut.actionButtonTapped
                        .subscribe(onNext: {
                            actionTriggered = true
                        })
                        .disposed(by: disposeBag)
                    
                    sut.actionButton.sendActions(for: .touchUpInside)
                    
                    expect(actionTriggered).to(beTrue())
                }
            }
            
            context("when taking a snapshot of the view") {
                it("should match the expected layout with custom title and description") {
                    sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                    
                    expect(sut).to(haveValidSnapshot())
                }
            }
        }
    }
}
