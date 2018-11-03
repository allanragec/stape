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
    }

    private func getData() {
        guard let viewController = viewController else { return }
        
        let artist = viewController.artist
        
        items = [ArtistDetailHeaderCellItem(artist: artist),
                 ArtistDetailsTopMusicsCellItem(artist: artist),
                 AritstDetailsDiscographyCellItem(artist: artist)]
        
        return
        
//        let interactor = GetAlbumsInteractor(artistId: viewController.artist.id, index: 5)
//        
//        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
//        
//        disposable = interactor.execute()
//            .subscribeOn(backgroundThread)
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext:     { self.appendTotalAlbums(albums: $0) },
//                       onError:    { error in self.verifyError(error) },
//                       onDisposed: { self.disposable = nil })
//        
//        disposable?.disposed(by: viewController.rx.disposeBag)
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
