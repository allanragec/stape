//
//  GetAlbumTracksInteractorTest.swift
//  StapeTests
//
//  Created by Allan Melo on 03/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Stape

class GetAlbumTracksInteractorTest: XCTestCase {
    
    let interactor = GetAlbumTracksInteractor(albumId: 2796761)
    
    func testGetAlbumsInteractor() {
        let albums = try? interactor.execute().asObservable().toBlocking().single()
        XCTAssertNotNil(albums)
        XCTAssertEqual(albums?.count, 6)
    }
    
}
