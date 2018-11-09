//
//  ArtistDetailsViewModel.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift
import NSObject_Rx


class ArtistDetailsViewModel {
    
    weak var viewController: ArtistDetailsViewController?
    
    var disposable: Disposable?
    
    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }
    
    init(_ viewController: ArtistDetailsViewController) {
        self.viewController = viewController
    }
    
    //MARK: Lifecycle methods
    
    func viewDidLoad() {
        registerCellItems()
        
        getData()
    }
    
    //MARK: Public methods
    
    func refresh() {
        disposable?.dispose()
        
        getData()
    }

    //MARK: Private methods
    
    private func updateData() {
        guard let viewController = viewController else { return }

        viewController.tableView.reloadData()
        viewController.refreshControl.endRefreshing()
        
        viewController.navigationItem.title = viewController.artist.name
    }

    private func getData() {
        guard let viewController = viewController else { return }
        
        let artist = viewController.artist
        
        items = [ArtistDetailHeaderCellItem(artist: artist),
                 ArtistDetailsTopMusicsCellItem(artist: artist),
                 AritstDetailsDiscographyCellItem(artist: artist)]
    }
    
    private func appendTotalAlbums(albums: [Album]) {
        guard let viewController = viewController else { return }
        
        viewController.artist.albums?.append(contentsOf: albums)
    }
    
    private func verifyError(_ error: Error) {
        Alert.showNetworkError(error) { [weak self] in
            self?.viewController?.refreshControl.endRefreshing()
        }
    }
}

extension ArtistDetailsViewModel: ModularViewModel {
    func registerCellItems() {
        guard let tableView = getTableView() else { return }
        
        tableView.register(cellController: ArtistDetailHeaderCellItem.self)
        tableView.register(cellController: ArtistDetailsTopMusicsCellItem.self)
        tableView.register(cellController: AritstDetailsDiscographyCellItem.self)
    }
    
    func getTableView() -> UITableView? {
        return viewController?.tableView
    }
    
    func getItems() -> [CellItemController] {
        return items
    }
}
