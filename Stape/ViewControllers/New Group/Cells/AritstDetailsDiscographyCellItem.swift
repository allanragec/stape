//
//  AritstDetailsDiscographyCellItem.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class AritstDetailsDiscographyCellItem: CellItemController {
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ArtistTableViewCell
        cell?.configure(artist: artist, title: "Discography")
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "ArtistTableViewCell"
    }
    
    func openCell() {
        guard let navigation = STTabBarController.shared.currentNavigation() else { return }

        let artistAlbumsViewController = ArtistAlbumsViewController(artist: artist)
        navigation.pushViewController(artistAlbumsViewController, animated: true)
    }
}

