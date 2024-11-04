import Foundation

enum LocalizedString: String {
    case titleHome = "title_home"
    case descripitionHome = "description_home"
    case titleButtonHome = "title_home_button"

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
