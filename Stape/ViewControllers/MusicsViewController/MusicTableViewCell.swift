//
//  MusicTableViewCell.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func prepareForReuse() {
        coverImageView.sd_cancelCurrentImageLoad()
    }
    func configure(music: Music) {
        let imageUrl = URL(string: music.album?.coverMedium ?? "")
        coverImageView.sd_setImage(with: imageUrl, completed: nil)
        
        titleLabel.text = music.title
        subtitleLabel.text = "\(music.artist.name) - \(music.album?.title ?? "")"
    }
}
