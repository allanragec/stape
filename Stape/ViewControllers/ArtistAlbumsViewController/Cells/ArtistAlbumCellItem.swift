//
//  ArtistAlbumCellItem.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class ArtistAlbumCellItem: CellItemController {
    let album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ArtistAlbumTableViewCell
        cell?.configure(album: album)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "ArtistAlbumTableViewCell"
    }
    
    func openCell() {
        guard let navigation = STTabBarController.shared.currentNavigation() else { return }
        
        let albumDetailsViewController = AlbumDetailsViewController(album: album)
        
        navigation.pushViewController(albumDetailsViewController, animated: true)
    }
}


