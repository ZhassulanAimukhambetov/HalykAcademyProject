//
//  Assembly.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 27.05.2022.
//

import Foundation
import UIKit

final class Assembly {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    let favoritesService: FavoritesServiceProtocol = FavoritesLocalService()
    
    static let assembler: Assembly = .init()
    
    private lazy var stocksService: StocksServiceProtocol = StocksService(client: network)
    
    func stocksModule() -> UIViewController {
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
    
    func detailVC(for model: StockModelProtocol) -> UIViewController {
        let presneter = DetailStockPresenter(model: model, service: stocksService)
        let view = DetailStockViewController(presneter: presneter)
        presneter.view = view
        
        return view
    }
}
