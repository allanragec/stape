//
//  LoaderObservable.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

protocol LoaderObservable  {
    associatedtype T : Codable
    
    func getUrl() -> String
    func createObservable() -> Observable<T>
}

extension LoaderObservable {
    
    func createObservable() -> Observable<T> {
        return Observable.create{ observer in
            guard let url = URL(string: self.getUrl()) else {
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
                
                do {
                    let type = try T(with: data)
                    observer.onNext(type)
                    observer.onCompleted()
                }
                catch let error {
                    observer.onError(error)
                }
            })
            
            task.resume()
            
            return Disposables.create {
                task.suspend()
            }
        }
    }
}
