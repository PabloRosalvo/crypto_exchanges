import UIKit

enum TrustRank {
    case highlyReliable
    case reliable
    case notRated
    case lowTrust

    init(from rank: Int) {
        switch rank {
        case 1:
            self = .highlyReliable
        case 2:
            self = .reliable
        case 0:
            self = .notRated
        default:
            self = .lowTrust
        }
    }

    var icon: String {
        switch self {
        case .highlyReliable: return "checkmark.shield"
        case .reliable: return "shield"
        case .notRated: return "info.circle"
        case .lowTrust: return "exclamationmark.triangle"
        }
    }

    var message: String {
        switch self {
        case .highlyReliable: return "Altamente confiável e segura para transações."
        case .reliable: return "Confiável para transações, com segurança moderada."
        case .notRated: return "Sem avaliação de confiança disponível."
        case .lowTrust: return "Menor nível de confiabilidade. Proceda com cautela."
        }
    }

    var color: UIColor {
        switch self {
        case .highlyReliable: return .systemGreen
        case .reliable: return .systemYellow
        case .notRated: return .systemGray
        case .lowTrust: return .systemRed
        }
    }
}
