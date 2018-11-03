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
        return Observable.create { observer in
            guard let url = URL(string: self.music.preview) else {
                observer.onError(ServerErrors.invalidRequest)
                
                return Disposables.create {}
            }

            let configuration = URLSession.shared.configuration
            configuration.timeoutIntervalForRequest = 10

            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
                else if let error = error {
                    observer.onError(error)
                }
                else {
                    observer.onError(ServerErrors.connectionError)
                }
            })
            
            task.resume()
            
            return Disposables.create {
                task.suspend()
            }
        }
    }
}
