//
//  TopMusicsCellItem.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class TopMusicsCellItem: CellItemController {
    let music: Music
    let musics: [Music]
    
    init(music: Music, musics: [Music]) {
        self.music = music
        self.musics = musics
    }
    
    func cell(tableView: UITableView) -> UITableViewCell {
        let identifier = type(of: self).getIdentifier()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MusicTableViewCell
        cell?.configure(music: music)
        
        return cell ?? UITableViewCell(frame: CGRect.zero)
    }
    
    static func getIdentifier() -> String {
        return "MusicTableViewCell"
    }
    
    func openCell() {
        let controller = STTabBarController.shared
        
        controller.showPlayer(music: music, musics: musics)
    }
}
