//
//  HomeViewController.swift
//  Stape
//
//  Created by Allan Melo on 30/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class HomeViewController: ModularViewController<HomeViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel(self)
    }()
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func getViewModel() -> HomeViewModel {
        return viewModel
    }
}
