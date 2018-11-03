//
//  AlbumMusicTableViewCell.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class AlbumMusicTableViewCell: UITableViewCell {
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    func configure(index: Int, music: Music) {
        indexLabel.text = "\(index)."
        musicNameLabel.text = music.title
    }
}
