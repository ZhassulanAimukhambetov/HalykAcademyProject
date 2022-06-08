//
//  StocksMVVMViewController.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 08.06.2022.
//

import UIKit

final class StocksMVVMViewController: UIViewController {
    private let viewModel: StocksViewModel
    private let tableView = UITableView()
    private var stocks: [StockModelProtocol] = []
    
    override func loadView() {
        view = tableView
    }
    
    init(viewModel: StocksViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.stocks = { [weak self] stocks in
            self?.stocks = stocks
            self?.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        
        viewModel.load()
    }
}

extension StocksMVVMViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.configure(with: stocks[indexPath.row])
        return cell
    }
}
