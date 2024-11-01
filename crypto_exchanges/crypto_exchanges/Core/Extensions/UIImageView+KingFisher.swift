import UIKit
import Kingfisher

extension UIImageView {
    func setImage(from urlString: String, forceRefresh: Bool = false) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let options: KingfisherOptionsInfo = forceRefresh ? [.forceRefresh] : []
        
        self.kf.setImage(with: url, options: options) { result in
            switch result {
            case .success(let value):
                print("\(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
