//
//  UserDefaultsFavoritesService.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 30.05.2022.
//

import Foundation

///Реализация сохранения избранных в UserDefaults
///Написали только для примера. Использовать его не будем.
final class FavoritesService: FavoritesServiceProtocol {
    private let key = "favorite_key"
    private lazy var favoriteIds: [String] = {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data,
              let ids = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        
        return ids
    }()
    
    func save(id: String) {
        favoriteIds.append(id)
        updateRepo()
    }
    
    func remove(id: String) {
        if let index = favoriteIds.firstIndex(where: { $0 == id }) {
            favoriteIds.remove(at: index)
            updateRepo()
        }
    }
    
    func isFavorite(for id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    private func updateRepo() {
        guard let data = try? JSONEncoder().encode(favoriteIds) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: key)
        print("UserDefaults update")
    }
}
