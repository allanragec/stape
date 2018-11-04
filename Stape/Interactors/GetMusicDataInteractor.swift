//
//  GetMusicInteractor.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class GetMusicDataInteractor {
    let music: Music
    
    init(music: Music) {
        self.music = music
    }
    
    func execute() -> Observable<Data> {
        return createDataObservable()
    }
}

extension GetMusicDataInteractor: LoaderDataObservable {
    func getUrl() -> String {
        return self.music.preview
    }
}
