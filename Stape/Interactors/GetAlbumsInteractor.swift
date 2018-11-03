//
//  GetAlbumsInteractor.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class GetAlbumsInteractor {
    let url: String
    
    init(artistId: Int64, limit: Int = 5, index: Int = 0) {
        self.url = "https://api.deezer.com/artist/\(artistId)/albums?limit=\(limit)&index=\(index)"
    }
    
    func execute() -> Observable<[Album]> {
        return createObservable().map{ $0.data }
    }
}

extension GetAlbumsInteractor: LoaderObservable {
    typealias T = AlbumsCollection
    
    func getUrl() -> String {
        return url
    }
}
