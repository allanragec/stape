//
//  MusicsViewModel.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class MusicsViewModel {
    
    weak var viewController: MusicsViewController?
    
    var disposable: Disposable?
    
    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }
    
    init(_ viewController: MusicsViewController) {
        self.viewController = viewController
    }
    
    //MARK: Lifecycle methods
    
    func viewDidLoad() {
        guard let viewController = viewController else { return }
        
        registerCellItems()
        viewController.navigationItem.title = "\(viewController.artist.name) - Top Musics"
        
        viewController.activityIndicator.startAnimating()
        getFavoriteArtists()
    }
    
    //MARK: Public methods
    
    func refresh() {
        disposable?.dispose()
        
        getFavoriteArtists()
    }
    
    //MARK: Private methods
    
    private func updateData() {
        guard let viewController = viewController else { return }
        
        viewController.tableView.reloadData()
        viewController.activityIndicator.stopAnimating()
        viewController.refreshControl.endRefreshing()
    }
    
    private func getFavoriteArtists() {
        guard let viewController = viewController else { return }
        let interactor = GetTopMusicsInteractor(artistId: viewController.artist.id, limit: 100)
        
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        
        disposable = interactor.execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .map { musics in musics.map { music in MusicsCellItem(music: music, musics: musics) } }
            .subscribe(onNext:     { self.items = $0 },
                       onError:    { error in self.verifyError(error) },
                       onDisposed: { self.disposable = nil })
        
        disposable?.disposed(by: viewController.rx.disposeBag)
    }
    
    private func verifyError(_ error: Error) {
        Alert.showNetworkError(error) { [weak self] in
            self?.viewController?.activityIndicator.stopAnimating()
            self?.viewController?.refreshControl.endRefreshing()
        }
    }
}

extension MusicsViewModel: ModularViewModel {
    func registerCellItems() {
        getTableView()?.register(cellController: MusicsCellItem.self)
    }
    
    func getTableView() -> UITableView? {
        return viewController?.tableView
    }
    
    func getItems() -> [CellItemController] {
        return items
    }
}
