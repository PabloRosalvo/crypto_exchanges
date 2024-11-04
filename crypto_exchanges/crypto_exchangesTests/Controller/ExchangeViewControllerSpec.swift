import Quick
import Nimble
import Nimble_Snapshots
import RxSwift

@testable import crypto_exchanges

class ExchangeViewControllerSpec: QuickSpec {
    
    override class func spec() {
        describe("ExchangeViewController") {
            var sut: ExchangeViewController!
            var mockViewModel: ExchangeViewModel!
            
            beforeEach {
                mockViewModel = ExchangeViewModel(apiService: MockExchangeAPI())
                sut = ExchangeViewController(viewModel: mockViewModel)
                
                WindowHelper.showInTestWindow(viewController: sut)
            }
            
            afterEach {
                WindowHelper.cleanTestWindow()
            }
            
            it("should have a valid snapshot") {
                expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(2))
            }
            
            
            
            
            it("should have a valid snapshot") {
                expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(2))
            }
        }
    }
}
