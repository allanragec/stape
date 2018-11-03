//
//  ModularViewController.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class ModularViewController<T : ModularViewModel> : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ModularViewController.refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = getTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        
        getViewModel().viewDidLoad()
    }
    
    @objc func refresh() {
        getViewModel().refresh()
    }
    
    func getViewModel() -> T {
        fatalError("you need to implement your viewModel")
    }
    
    func getTableView() -> UITableView {
        fatalError("you need to implement your tableView")
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getViewModel().getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getViewModel().createCell(for: indexPath)
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getViewModel().open(for: indexPath)
    }
}

