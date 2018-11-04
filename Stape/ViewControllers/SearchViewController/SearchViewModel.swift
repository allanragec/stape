//
//  SearchViewModel.swift
//  Stape
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel {
    
    weak var viewController: SearchViewController?
    
    var items: [CellItemController] = [] {
        didSet {
            updateData()
        }
    }
    
    init(_ viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        registerCellItems()
        
        searchSubscribe()
    }
    
    func searchSubscribe() {
        guard let viewController = viewController else { return }
        
        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)
        
        viewController.searchBar.rx.text
            .asObservable()
            .skip(1)
            .debounce(0.4, scheduler: MainScheduler.instance)
            .map { $0 ?? "" }
            .distinctUntilChanged { textBefore, textAfter in
                let textBeforeTrimmed = textBefore.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines)
                
                let textAfterTrimmed = textAfter.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines)
                
                return textBeforeTrimmed == textAfterTrimmed
            }
            .filter{ query in
                if query.count > 2 {
                    return true
                }

                self.items = []
                
                return false
            }
            .do(onNext: { _ in viewController.activityIndicator.startAnimating() })
            .flatMap { SearchInteractor(query: $0).execute() }
            .map { musics in musics.map { MusicsCellItem(music: $0, musics: musics) } }
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:     { self.items = $0 },
                       onError:    { error in self.verifyError(error) })
            .disposed(by: viewController.rx.disposeBag)
    }
    
    func refresh() {}
    
    private func updateData() {
        guard let viewController = viewController else { return }
        
        viewController.tableView.reloadData()
        viewController.activityIndicator.stopAnimating()
    }
    
    private func verifyError(_ error: Error) {
        print("Search error \(error)")
        viewController?.activityIndicator.stopAnimating()
        
        searchSubscribe()
    }
}

extension SearchViewModel: ModularViewModel {
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

