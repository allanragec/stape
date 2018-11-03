//
//  GetFavoriteArtistsInteractorTest.swift
//  StapeTests
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Stape

class GetFavoriteArtistsInteractorTest: XCTestCase {
    
    override func setUp() {
        Settings.userId = "2401111128"
    }
    
    func testGetAlbumsInteractor() {
        let interactor = GetFavoriteArtistsInteractor()
        
        let artists = try? interactor.execute().asObservable().toBlocking().single()
        XCTAssertNotNil(artists)
        XCTAssertEqual(artists?.count, 3)
    }
    
    func testGetAlbumsInteractorWithAlbums() {
        let interactor = GetFavoriteArtistsInteractor()
        
        guard let artists = try? interactor.execute(withAlbums: true).asObservable().toBlocking().single() else {
            return assertionFailure("could not parse artists")
        }
        
        XCTAssertNotNil(artists)
        XCTAssertFalse(artists.isEmpty)
        
        for artist in artists {
            let albums = artist.albums ?? []
            XCTAssertFalse(albums.isEmpty)
        }
    }
    
}
