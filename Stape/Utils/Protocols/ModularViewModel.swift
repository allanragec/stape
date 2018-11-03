//
//  ModularViewModel.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

protocol ModularViewModel {
    func registerCellItems()
    func viewDidLoad()
    func refresh()
    func getTableView() -> UITableView?
    func getItems() -> [CellItemController]
    func createCell(for index: IndexPath) -> UITableViewCell
    func open(for index: IndexPath)
}

extension ModularViewModel {
    func open(for index: IndexPath) {
        let items = getItems()
        
        guard index.row < items.count else { return }
        
        let item = items[index.row]
        
        item.openCell()
    }
    
    func createCell(for index: IndexPath) -> UITableViewCell {
        let items = getItems()
        
        guard let tableView = getTableView(), index.row < items.count else { return UITableViewCell(frame: CGRect.zero) }
        
        let item = items[index.row]
        
        return item.cell(tableView: tableView, indexPath: index)
    }
}

