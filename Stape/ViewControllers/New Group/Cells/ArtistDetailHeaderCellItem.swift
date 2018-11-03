//
//  ArtistDetailHeaderCellItem.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class ArtistDetailHeaderCellItem: CellItemController {
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    func cell(tableView: UITableView) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ArtistDetailHeaderTableViewCell
        cell?.configure(artist: artist)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "ArtistDetailHeaderTableViewCell"
    }
    
    func openCell() {}
}
