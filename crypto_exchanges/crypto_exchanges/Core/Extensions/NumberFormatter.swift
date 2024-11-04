
import Foundation

extension Double {
    func formatAsUSNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // Define o estilo como decimal
        formatter.locale = Locale(identifier: "en_US") // Define o local para os Estados Unidos
        formatter.minimumFractionDigits = 2 // Define o mínimo de casas decimais
        formatter.maximumFractionDigits = 2 // Define o máximo de casas decimais
        
        if let formattedValue = formatter.string(from: NSNumber(value: self)) {
            return formattedValue
        } else {
            return "0.00"
        }
    }
}
