//
//  SearchViewController.swift
//  Stape
//
//  Created by Allan Melo on 30/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class SearchViewController: ModularViewController<SearchViewModel> {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
    }
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func getViewModel() -> SearchViewModel {
        return viewModel
    }
}
