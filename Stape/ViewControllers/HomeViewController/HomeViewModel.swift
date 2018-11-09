//
//  HomeViewModel.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class HomeViewModel {
    
    weak var viewController: HomeViewController?
    
    var disposable: Disposable?
    
    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }
    
    init(_ viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    //MARK: Lifecycle methods
    
    func viewDidLoad() {
        guard let viewController = viewController else { return }
        
        registerCellItems()
        
        viewController.activityIndicator.startAnimating()
        getFavoriteArtists()
        
        viewController.navigationItem.title = "Home"
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
        let interactor = GetFavoriteArtistsInteractor()
        
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        
        disposable = interactor.execute(withAlbums: true, withTopMusics: true)
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .map { $0.map { ArtistHomeCellItem(artist: $0) } }
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

extension HomeViewModel: ModularViewModel {
    func registerCellItems() {
        getTableView()?.register(cellController: ArtistHomeCellItem.self)
    }
    
    func getTableView() -> UITableView? {
        return viewController?.tableView
    }
    
    func getItems() -> [CellItemController] {
        return items
    }
}
