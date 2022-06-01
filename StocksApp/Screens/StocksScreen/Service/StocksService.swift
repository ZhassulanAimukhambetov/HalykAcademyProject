//
//  StocksService.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 25.05.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func getStocks(carrency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(carrency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    
    func getCharts(id: String,
                   currency: String,
                   days: String,
                   isDaily: Bool,
                   completion: @escaping (Result<Charts, NetworkError>) -> Void)
}

final class StocksService: StocksServiceProtocol {
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(carrency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(carrency: carrency, count: count), completion: completion)
    }
    
    func getCharts(id: String,
                   currency: String,
                   days: String,
                   isDaily: Bool,
                   completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.charts(id: id, currency: currency, days: days, isDaily: isDaily), completion: completion)
    }
}

extension StocksServiceProtocol {
    func getStocks(carrency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: carrency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: "usd", completion: completion)
    }
}
