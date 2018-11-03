//
//  ArtistAlbumsViewController.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class ArtistAlbumsViewController: UIViewController {
    
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
        
        super.init(nibName: "ArtistAlbumsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
