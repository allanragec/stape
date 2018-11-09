//
//  ArtistAlbumsViewModel.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class ArtistAlbumsViewModel {
    weak var viewController: ArtistAlbumsViewController?
    
    var disposable: Disposable?
    
    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }
    
    init(_ viewController: ArtistAlbumsViewController) {
        self.viewController = viewController
    }
    
    //MARK: Lifecycle methods
    
    func viewDidLoad() {
        guard let viewController = viewController else { return }
        
        registerCellItems()
        viewController.navigationItem.title = viewController.artist.name
        
        viewController.activityIndicator.startAnimating()
        getAlbums()
    }
    
    //MARK: Public methods
    
    func refresh() {
        disposable?.dispose()
        
        getAlbums()
    }
    
    //MARK: Private methods
    
    func getAlbums() {
        guard let viewController = viewController else { return }
        let interactor = GetAlbumsInteractor(artistId: viewController.artist.id, limit: 100)
        
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        
        disposable = interactor.execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .map {$0.map { ArtistAlbumCellItem(album: $0) } }
            .subscribe(onNext:     { self.items = $0 },
                       onError:    { error in self.verifyError(error) },
                       onDisposed: { self.disposable = nil })
        
        disposable?.disposed(by: viewController.rx.disposeBag)
    }
    
    private func updateData() {
        guard let viewController = viewController else { return }
        
        viewController.tableView.reloadData()
        viewController.activityIndicator.stopAnimating()
        viewController.refreshControl.endRefreshing()
    }
    
    private func verifyError(_ error: Error) {
        Alert.showNetworkError(error) { [weak self] in
            self?.viewController?.activityIndicator.stopAnimating()
            self?.viewController?.refreshControl.endRefreshing()
        }
    }
}

extension ArtistAlbumsViewModel: ModularViewModel {
    func registerCellItems() {
        getTableView()?.register(cellController: ArtistAlbumCellItem.self)
    }
    
    func getTableView() -> UITableView? {
        return viewController?.tableView
    }
    
    func getItems() -> [CellItemController] {
        return items
    }
}


