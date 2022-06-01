//
//  StocksRouter.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 27.05.2022.
//

import Foundation

enum StocksRouter: Router {
    case stocks(carrency: String, count: String)
    case charts(id: String, currency: String, days: String, isDaily: Bool)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        case .charts(let id,_,_,_):
            return "/api/v3/coins/\(id)/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks, .charts:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let carrency, let count):
            return ["vs_currency": carrency, "per_page": count]
        case let .charts(_, currency, days, isDaily):
            return ["vs_currency": currency,
                    "days": days,
                    "interval": isDaily ? "daily" : ""]
        }
    }
}
