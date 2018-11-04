//
//  SearchInteractor.swift
//  Stape
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class SearchInteractor {
    let url: String
    
    init(query: String) {
        self.url = "https://api.deezer.com/search?q=\(query)&limit=30"
    }
    
    func execute() -> Observable<[Music]> {
        return createObservable().map{ $0.data }
    }
}

extension SearchInteractor: LoaderCodableObservable {
    typealias T = MusicsCollection
    
    func getUrl() -> String {
        return url
    }
}

