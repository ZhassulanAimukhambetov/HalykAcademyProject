//
//  StockModel.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 27.05.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changeColor: UIColor { get }
    
    var isFavotite: Bool { get set }
    
    func setFavorite()
}

final class StockModel: StockModelProtocol {
    private let stock: Stock
    private let favoriteService: FavoritesServiceProtocol

    init(stock: Stock) {
        self.stock = stock
        favoriteService = Assembly.assembler.favoritesService
        isFavotite = favoriteService.isFavorite(for: id)
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var price: String {
        "\(stock.price)"
    }
    
    var change: String {
        "\(stock.change) $ (\(stock.changePercentage)"
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .green : .red
    }
    
    var isFavotite: Bool = false
    
    func setFavorite() {
        isFavotite.toggle()
        
        if isFavotite {
            favoriteService.save(id: id)
        } else {
            favoriteService.remove(id: id)
        }
    }
}
