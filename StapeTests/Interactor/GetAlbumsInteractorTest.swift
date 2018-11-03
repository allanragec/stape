//
//  GetAlbumsInteractorTest.swift
//  StapeTests
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Stape

class GetAlbumsInteractorTest: XCTestCase {
    
    let interactor = GetAlbumsInteractor(artistId: 580)
    
    func testGetAlbumsInteractor() {
        let albums = try? interactor.execute().asObservable().toBlocking().single()
        XCTAssertNotNil(albums)
        XCTAssertEqual(albums?.count, 5)
    }
    
}
