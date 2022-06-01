//
//  DetailStockViewController.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 01.06.2022.
//

import UIKit

final class DetailStockViewController: UIViewController {
    private let presneter: DetailStockPresenterProtocol
    
    init(presneter: DetailStockPresenterProtocol) {
        self.presneter = presneter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = presneter.title
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupFavoriteButton()
        
        presneter.loadView()
    }
    
    private func setupFavoriteButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite-off"), for: .normal)
        button.setImage(.checkmark, for: .selected)
        button.addTarget(self, action: #selector(favotiteButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.isSelected = presneter.favoriteButtonIsSelected
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc private func favotiteButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presneter.favoriteButtonTapped()
    }
}


extension DetailStockViewController: DetailStockViewProtocol {
    func updateView() {
        
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
}
