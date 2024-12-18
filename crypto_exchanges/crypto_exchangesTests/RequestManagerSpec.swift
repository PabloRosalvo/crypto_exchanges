import Quick
import Nimble

@testable import crypto_exchanges

final class RequestManagerSpec: QuickSpec {
    override class func spec() {
        describe("RequestManager") {
            var requestManager: RequestManager!
            let baseURL = "https://api.mock.com"
            let endpoint = APIEndpoint.exchange
            var mockSession: MockURLSession!
            
            beforeEach {
                mockSession = MockURLSession()
                requestManager = RequestManager(session: mockSession)
            }
            
            it("should return success when the request is successful") {
                guard let mockData = Bundle.main.loadJsonData(fileName: "json-exchange") else {
                    fail("Erro ao carregar dados mock")
                    return
                }

                mockSession.nextData = mockData
                mockSession.nextResponse = HTTPURLResponse(url: URL(string: baseURL + endpoint.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
                
                waitUntil(timeout: .seconds(3)) { done in
                    requestManager.request(
                        baseURL: baseURL,
                        endpoint: .exchange,
                        method: .get,
                        parameters: nil,
                        headers: nil
                    ) { (result: Result<[Exchange]>) in
                        switch result {
                        case .success(let data):
                            expect(data).toNot(beNil())
                        case .failure:
                            fail("Request deveria ter sido bem-sucedida")
                        }
                        done()
                    }
                }
            }
            
            it("should return failure when the request fails") {
                mockSession.nextResponse = HTTPURLResponse(url: URL(string: baseURL + endpoint.path)!, statusCode: 400, httpVersion: nil, headerFields: nil)
                
                waitUntil(timeout: .seconds(3)) { done in
                    requestManager.request(
                        baseURL: baseURL,
                        endpoint: endpoint,
                        method: .get,
                        parameters: nil,
                        headers: nil
                    ) { (result: Result<[Exchange]>) in
                        switch result {
                        case .success:
                            fail("Request deveria ter falhado")
                        case .failure(let error):
                            print(error.statusCode)
                            expect(error.statusCode.rawValue).to(equal(400))
                        }
                        done()
                    }
                }
            }
        }
    }
}

class MockURLSession: URLSession, @unchecked Sendable {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.nextData, self.nextResponse, self.nextError)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
