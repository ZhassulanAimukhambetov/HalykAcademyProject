//
//  FavoritesService.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 29.05.2022.
//

import Foundation

///Сервис для сохранения избранных.
protocol FavoritesServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}
