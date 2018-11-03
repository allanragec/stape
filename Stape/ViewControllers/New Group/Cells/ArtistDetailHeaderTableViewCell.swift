//
//  ArtistDetailHeaderTableViewCell.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage
import UIImageColors

class ArtistDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var portraitBackgroundView: UIView!
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        sd_cancelCurrentImageLoad()
    }
    
    func configure(artist: Artist) {
        let url = URL(string: artist.pictureBig)
        
        portraitImageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
            guard let strongSelf = self else { return }
            
            strongSelf.portraitBackgroundView.backgroundColor = image?.getColors().primary.withAlphaComponent(0.2)
        }
        
        nameLabel.text = artist.name
    }
}
