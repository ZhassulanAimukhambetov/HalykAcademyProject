//
//  Assembly.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 27.05.2022.
//

import Foundation
import UIKit

final class Assembly {
    static let assembler: Assembly = .init()
    let favoritesService: FavoritesServiceProtocol = FavoritesLocalService()

    private init() {}

    private lazy var network: NetworkService = Network()
    private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
    private lazy var chartsService: ChartsServiceProtocol = ChartsService(network: network)
    
    private func stocksModule() -> UIViewController {
        let presneter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presneter)
        presneter.view = view
        
        return view
    }
    
    func secondVC() -> UIViewController {
        UIViewController()
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: .add, tag: 0)
        
        let secondVC = secondVC()
        secondVC.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 2)
        
        let thirdVC = thirdVC()
        thirdVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 2)
        
        tabbar.viewControllers = [stocksVC, secondVC, thirdVC]
        
        return tabbar
    }
    
    func detailVC(model: StockModelProtocol) -> UIViewController {
        let presenter = StockDetailPresenter(model: model, service: chartsService)
        let view = StockDetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
