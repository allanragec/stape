//
//  AlbumDetailsViewController.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: ModularViewController<AlbumDetailsViewModel> {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: AlbumDetailsViewModel = {
        return AlbumDetailsViewModel(self)
    }()
    
    let album: Album
    
    init(album: Album) {
        self.album = album
        
        super.init(nibName: "AlbumDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = album.title
    }
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func getViewModel() -> AlbumDetailsViewModel {
        return viewModel
    }
}
