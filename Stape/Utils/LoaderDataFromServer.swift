//
//  LoaderDataFromServer.swift
//  Stape
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class LoaderDataFromServer {
    func createObservable(url: String) -> Observable<Data> {
        return Observable.create{ observer in
            guard let url = URL(string: url) else {
                observer.onError(ServerErrors.invalidRequest)
                
                return Disposables.create {}
            }
            
            let configuration = URLSession.shared.configuration
            configuration.timeoutIntervalForRequest = 10
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    observer.onError(error ?? ServerErrors.connectionError)
                    
                    return
                }
                
                observer.onNext(data)
                observer.onCompleted()
            })
            
            task.resume()
            
            return Disposables.create {
                task.suspend()
            }
        }
    }
}
