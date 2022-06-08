//
//  StocksPresenterTest.swift
//  StocksAppTests
//
//  Created by Aimukhambetov Zhassulan on 08.06.2022.
//

import XCTest
@testable import StocksApp

class StocksPresenterTest: XCTestCase {
    
    private var presenter: StocksPresenter!
    
    func testItemCount() {
        let empryService = MockStocksServiceEmpty()
        presenter = StocksPresenter(service: empryService)
        presenter.loadView()
        
        XCTAssertEqual(presenter.itemsCount, 0, "Количество айтемов не равно 0, хотя мы передавали пустой массив!")
        
        let twoItemService = MockStocksServiceTwoItems()
        presenter = StocksPresenter(service: twoItemService)
        presenter.loadView()
        
        XCTAssertEqual(presenter.itemsCount, 2, "Количество айтемов не равно 2, хотя мы передавали массив из двух элементов!")
        
        let mockService = MockService()
        presenter = StocksPresenter(service: mockService)
        presenter.loadView()
        
        XCTAssertEqual(presenter.itemsCount, 100, "Количество айтемов не равно 100, хотя мы передавали массив из 100 элементов!")
    }
    
    
    func testStockModel() {
        let mockService = MockStocksServiceTwoItems()
        presenter = StocksPresenter(service: mockService)
        presenter.loadView()
        
        let model1 = presenter.model(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(model1.id, "stock1", "id модели не совпадает!")
        
        let model2 = presenter.model(for: IndexPath(row: 1, section: 0))
        XCTAssertEqual(model2.id, "stock2", "id модели не совпадает!")
    }
}




class MockStocksServiceEmpty: StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        completion(.success([]))
    }
}


class MockStocksServiceTwoItems: StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        let stock1 = Stock(id: "stock1", symbol: "", name: "", image: "", price: 0, change: 0, changePercentage: 0)
        let stock2 = Stock(id: "stock2", symbol: "", name: "", image: "", price: 0, change: 0, changePercentage: 0)

        completion(.success([StockModel(stock: stock1), StockModel(stock: stock2)]))
    }
}
