//
//  GetTopMusicsInteractorTest.swift
//  StapeTests
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Stape

class GetTopMusicsInteractorTest: XCTestCase {
    
    let interactor = GetTopMusicsInteractor(artistId: 580)
    
    func testGetAlbumsInteractor() {
        let albums = try? interactor.execute().asObservable().toBlocking().single()
        XCTAssertNotNil(albums)
        XCTAssertEqual(albums?.count, 3)
    }
    
}

