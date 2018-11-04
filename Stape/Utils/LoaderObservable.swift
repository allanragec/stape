//
//  LoaderObservable.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

protocol LoaderCodableObservable  {
    associatedtype T : Codable
    
    func getUrl() -> String
    func createObservable() -> Observable<T>
}

extension LoaderCodableObservable {
    func createObservable() -> Observable<T> {
        return LoaderDataFromServer()
            .createObservable(url: getUrl())
            .map { try T(with: $0) }
    }
}

protocol LoaderDataObservable  {
    func getUrl() -> String
    func createDataObservable() -> Observable<Data>
}

extension LoaderDataObservable {
    func createDataObservable() -> Observable<Data> {
        return LoaderDataFromServer()
            .createObservable(url: getUrl())
    }
}


