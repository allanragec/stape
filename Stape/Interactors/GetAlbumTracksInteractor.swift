//
//  GetAlbumTracksInteractor.swift
//  Stape
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class GetAlbumTracksInteractor {
    let url: String
    
    init(albumId: Int64) {
        self.url = "https://api.deezer.com/album/\(albumId)/tracks"
    }
    
    func execute() -> Observable<[Music]> {
        return createObservable().map{ $0.data }
    }
}

extension GetAlbumTracksInteractor: LoaderCodableObservable {
    typealias T = MusicsCollection
    
    func getUrl() -> String {
        return url
    }
}
