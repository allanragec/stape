//
//  CellItemController.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

protocol CellItemController {
    static func getIdentifier() -> String
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func openCell()
}
