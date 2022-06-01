//
//  DetailStockPresenter.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 01.06.2022.
//

import Foundation

protocol DetailStockViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol DetailStockPresenterProtocol {
    var favoriteButtonIsSelected: Bool { get }
    var title: String? { get }
    
    func loadView()
    func favoriteButtonTapped()
}


final class DetailStockPresenter: DetailStockPresenterProtocol {
    private let model: StockModelProtocol
    private let service: StocksServiceProtocol
    
    weak var view: DetailStockViewProtocol?
    
    var favoriteButtonIsSelected: Bool {
        model.isFavotite
    }
    
    var title: String? {
        model.name
    }

    init(model: StockModelProtocol, service: StocksServiceProtocol) {
        self.model = model
        self.service = service
    }
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getCharts(id: model.id, currency: "usd", days: "100", isDaily: true) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let charts):
                self?.view?.updateView()
                print("Chrats count - ", charts.prices.map { $0.price })
            case .failure(let error):
                self?.view?.updateView(withError: error.rawValue)
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
    
    private func Task2() {
        
    }
    
}
