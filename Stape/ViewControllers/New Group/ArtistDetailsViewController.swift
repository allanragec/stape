//
//  ArtistDetailsViewController.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit
import SDWebImage

class ArtistDetailsViewController: ModularViewController<ArtistDetailsViewModel> {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: ArtistDetailsViewModel = {
        return ArtistDetailsViewModel(self)
    }()
    
    var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist

        super.init(nibName: "ArtistDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func getViewModel() -> ArtistDetailsViewModel {
        return viewModel
    }
}
