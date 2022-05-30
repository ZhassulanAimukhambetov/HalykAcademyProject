//
//  FileManagerFavoritesService.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 30.05.2022.
//

import Foundation

///Реализация сохранения в избранное в локальный файл.
final class FavoritesLocalService: FavoritesServiceProtocol {
    private lazy var path: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Favorites")
    }()
    
    private lazy var favoriteIds: [String] = {
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("FileManager ReadError - ", error.localizedDescription)

        }
        
        return []
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
        do {
            let data = try JSONEncoder().encode(favoriteIds)
            try data.write(to: path)
        } catch {
            print("FileManager WriteError - ", error.localizedDescription)
        }
    }
}
