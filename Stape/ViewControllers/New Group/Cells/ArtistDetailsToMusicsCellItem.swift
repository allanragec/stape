//
//  ArtistDetailsToMusicsCellItem.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class ArtistDetailsTopMusicsCellItem: CellItemController {
    
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    func cell(tableView: UITableView) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ArtistDetailsTopMusicsTableViewCell
        cell?.configure(artist: artist)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "ArtistDetailsTopMusicsTableViewCell"
    }
    
    func openCell() {
        guard let navigation = STTabBarController.shared.currentNavigation() else { return }
        
        let artistDetailsViewController = MusicsViewController(artist: artist)
        navigation.pushViewController(artistDetailsViewController, animated: true)
    }
}
