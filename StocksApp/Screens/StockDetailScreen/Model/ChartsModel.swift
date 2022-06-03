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
        return ChartsModel(periods: [])
    }
}
