//
//  AlbumDetailsViewModel.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class AlbumDetailsViewModel {
    
    weak var viewController: AlbumDetailsViewController?
    
    var disposable: Disposable?
    
    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }
    
    init(_ viewController: AlbumDetailsViewController) {
        self.viewController = viewController
    }
    
    //MARK: Lifecycle methods
    
    func viewDidLoad() {
        guard let viewController = viewController else { return }
        
        registerCellItems()
        
        viewController.activityIndicator.startAnimating()
        getTracks()
    }
    
    //MARK: Public methods
    
    func refresh() {
        viewController?.refreshControl.endRefreshing()
        disposable?.dispose()
        
        getTracks()
    }
    
    //MARK: Private methods
    
    private func getTracks() {
        guard let viewController = viewController else { return }
        let album = viewController.album
        let shortAlbum = album.toShortAlbum()
        let interactor = GetAlbumTracksInteractor(albumId: album.id)
        
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        
        disposable = interactor.execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .map { musics in
                return musics.map({
                    var music = $0
                    music.album = shortAlbum
                    
                    return music
                })
            }
            .map { musics in musics.map { music in AlbumMusicCellItem(music: music, musics: musics) } }
            .subscribe(onNext:     { self.reloadtems(items: $0) },
                       onError:    { error in self.verifyError(error) },
                       onDisposed: { self.disposable = nil })
        
        disposable?.disposed(by: viewController.rx.disposeBag)
    }
    
    private func reloadtems(items: [CellItemController]) {
         guard let album = viewController?.album else { return }
        
        var newItems: [CellItemController] = [AlbumDetailHeaderCellItem(album: album)]
        newItems += items
        self.items = newItems
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

extension AlbumDetailsViewModel: ModularViewModel {
    func registerCellItems() {
        getTableView()?.register(cellController: AlbumDetailHeaderCellItem.self)
        getTableView()?.register(cellController: AlbumMusicCellItem.self)
    }
    
    func getTableView() -> UITableView? {
        return viewController?.tableView
    }
    
    func getItems() -> [CellItemController] {
        return items
    }
}
