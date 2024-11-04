//
//  ExchangeIcon.swift
//  crypto_exchanges
//
//  Created by Pablo Rosalvo de Melo Lopes on 03/11/24.
//

public struct ExchangeIcon: Codable {
    let exchangeID: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case exchangeID = "exchange_id"
        case url
    }
}
