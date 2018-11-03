//
//  AlbumDetailsViewController.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    let album: Album
    
    init(album: Album) {
        self.album = album
        
        super.init(nibName: "AlbumDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.title = album.title
    }

}
