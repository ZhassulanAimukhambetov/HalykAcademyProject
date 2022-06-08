//
//  StocksModelMVVM.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 08.06.2022.
//

import Foundation

final class StocksModelMVVM {
    private let service: StocksServiceProtocol
    var items: ((Result<[StockModelProtocol], Error>) -> Void)?
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    func loadItems() {
        service.getStocks { [weak self] result in
            switch result {
            case .success(let items):
                self?.items?(.success(items))
            case .failure(let error):
                self?.items?(.failure(error))
            }
        }
    }
}
