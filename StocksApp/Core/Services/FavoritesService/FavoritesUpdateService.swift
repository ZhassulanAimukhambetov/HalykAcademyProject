//
//  FavoritesUpdateService.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 01.06.2022.
//

import Foundation

@objc protocol FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification)
}

extension FavoritesUpdateServiceProtocol {
    func startObservingFavoriteNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setFavorite),
                                               name: NSNotification.Name.favoriteNotifacation,
                                               object: nil)
    }
}

extension NSNotification.Name {
    static let favoriteNotifacation = NSNotification.Name("set_favorite")
}


extension Notification {
    var stockID: String? {
        guard let userInfo = userInfo,
              let id = userInfo["id"] as? String else { return nil }
        
        return id
    }
}
