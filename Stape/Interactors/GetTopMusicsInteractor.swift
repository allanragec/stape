//
//  GetTopMusicsInteractor.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class GetTopMusicsInteractor {
    
    let url: String
    
    init(artistId: Int64, limit: Int = 3) {
        self.url = "https://api.deezer.com/artist/\(artistId)/top?limit=\(limit)"
    }
    
    func execute() -> Observable<[Music]> {
        return createObservable().map{ $0.data }
    }
}

extension GetTopMusicsInteractor: LoaderObservable {
    typealias T = TopMusicsCollection
    
    func getUrl() -> String {
        return url
    }
}
