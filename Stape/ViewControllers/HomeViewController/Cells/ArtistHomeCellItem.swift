//
//  ArtistHomeCellItem.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class ArtistHomeCellItem: CellItemController {
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    func cell(tableView: UITableView) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ArtistTableViewCell
        cell?.configure(artist: artist, title: artist.name)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "ArtistTableViewCell"
    }
    
    func openCell() {
        guard let navigation = STTabBarController.shared.currentNavigation() else { return }
        
        let artistDetailsViewController = ArtistDetailsViewController(artist: artist)
        navigation.pushViewController(artistDetailsViewController, animated: true)
    }
}

