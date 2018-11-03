//
//  ArtistAlbumTableViewCell.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class ArtistAlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func prepareForReuse() {
        coverImageView.sd_cancelCurrentImageLoad()
    }
    
    func configure(album: Album) {
        let imageUrl = URL(string: album.coverBig)
        coverImageView.sd_setImage(with: imageUrl, completed: nil)
        titleLabel.text = album.title
        subtitleLabel.text = "⭐ \(album.fans)"
    }
}
