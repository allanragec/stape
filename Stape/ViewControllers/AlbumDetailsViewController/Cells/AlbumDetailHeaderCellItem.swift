//
//  ArtistDetailHeaderCellItem.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class AlbumDetailHeaderCellItem: CellItemController {
    let album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AlbumDetailHeaderTableViewCell
        cell?.configure(album: album)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "AlbumDetailHeaderTableViewCell"
    }
    
    func openCell() {}
}
