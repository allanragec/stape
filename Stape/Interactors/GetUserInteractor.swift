//
//  GetUserInteractor.swift
//  Stape
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import RxSwift

class GetUserInteractor {
    let url: String
    
    init(userId: String) {
        self.url = "https://api.deezer.com/user/\(userId)"
    }
    
    func execute() -> Observable<User> {
        return createObservable()
    }
}

extension GetUserInteractor: LoaderCodableObservable {
    typealias T = User
    
    func getUrl() -> String {
        return url
    }
}
