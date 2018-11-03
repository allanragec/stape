//
//  AlbumMusicCellItem.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class AlbumMusicCellItem: CellItemController {
    let music: Music
    let musics: [Music]
    
    init(music: Music, musics: [Music]) {
        self.music = music
        self.musics = musics
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AlbumMusicTableViewCell
        cell?.configure(index: indexPath.row, music: music)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "AlbumMusicTableViewCell"
    }
    
    func openCell() {
        let controller = STTabBarController.shared
        
        controller.showPlayer(music: music, musics: musics)
    }
}

