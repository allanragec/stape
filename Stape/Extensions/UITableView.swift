//
//  UITableView.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

extension UITableView {
    func register<T: CellItemController>(cellController: T.Type) {
        let identifier = cellController.getIdentifier()
        let nibCell = UINib(nibName: identifier, bundle: nil)
        register(nibCell, forCellReuseIdentifier: identifier)
    }
}
