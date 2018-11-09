//
//  ArtistAlbumsViewController.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit


class ArtistAlbumsViewController: ModularViewController<ArtistAlbumsViewModel> {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: ArtistAlbumsViewModel = {
        return ArtistAlbumsViewModel(self)
    }()
    
    let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
        
        super.init(nibName: "ArtistAlbumsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func getViewModel() -> ArtistAlbumsViewModel {
        return viewModel
    }
}
