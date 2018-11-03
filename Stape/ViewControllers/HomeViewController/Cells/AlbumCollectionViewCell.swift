//
//  AlbumCollectionViewCell.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        imageView.sd_cancelCurrentImageLoad()
    }
    
    func configure(album: Album) {
        let imageUrl = URL(string: album.coverBig)
        imageView.sd_setImage(with: imageUrl, completed: nil)
        
        titleLabel.text = album.title
        subTitleLabel.text = "⭐ \(album.fans)"
        dateLabel.text = String(album.releaseDate.prefix(4))
    }
}
