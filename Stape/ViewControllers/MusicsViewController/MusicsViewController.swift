//
//  MusicsViewController.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class MusicsViewController: ModularViewController<MusicsViewModel> {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: MusicsViewModel = {
        return MusicsViewModel(self)
    }()
    
    var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
        
        super.init(nibName: "MusicsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        navigationItem.title = "\(artist.name) - Top Musics"
    }
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func getViewModel() -> MusicsViewModel {
        return viewModel
    }
}
