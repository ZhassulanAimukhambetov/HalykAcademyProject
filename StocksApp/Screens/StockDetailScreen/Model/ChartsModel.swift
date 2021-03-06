//
//  ChartsModel.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 03.06.2022.
//

import Foundation

struct ChartsModel {
    let periods: [Period]
    
    struct Period {
        let name: String
        let prices: [Double]
    }
    
    static func build(from charts: Charts) -> ChartsModel {
        return ChartsModel(periods: [Period(name: "W", prices: charts.prices.map { $0.price }),
                                     Period(name: "M", prices: []),
                                     Period(name: "6M", prices: []),
                                     Period(name: "1Y", prices: [])])
    }
}

