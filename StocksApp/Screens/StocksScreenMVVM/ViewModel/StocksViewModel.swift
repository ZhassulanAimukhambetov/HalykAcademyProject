//
//  StocksViewModel.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 08.06.2022.
//

import Foundation

final class StocksViewModel {
    private let model: StocksModelMVVM
    var stocks: (([StockModelProtocol]) -> Void)?
    
    init(model: StocksModelMVVM) {
        self.model = model
        
        self.model.items = { result in
            switch result {
            case .success(let stocks):
                self.stocks?(stocks)
            case .failure:
                print("Error")
            }
        }
    }
    
    func load() {
        model.loadItems()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stocks?([])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.model.loadItems()
        }
    }
}
