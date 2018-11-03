//
//  ArtistDetailsTopMusicsTableViewCell.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class ArtistDetailsTopMusicsTableViewCell: UITableViewCell {
    @IBOutlet weak var trackOneNameLabel: UILabel!
    @IBOutlet weak var trackTwoNameLabel: UILabel!
    @IBOutlet weak var trackThreeNameLabel: UILabel!
    
    func configure(artist: Artist) {
        trackOneNameLabel.text = artist.musics?[0].title ?? ""
        trackTwoNameLabel.text = artist.musics?[1].title ?? ""
        trackThreeNameLabel.text = artist.musics?[2].title ?? ""
    }
}
