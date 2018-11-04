//
//  SearchInteractorTest.swift
//  StapeTests
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import Foundation



import XCTest
import RxBlocking

@testable import Stape

class SearchInteractorTest: XCTestCase {
    
    let interactor = SearchInteractor(query: "ACDC")
    
    func testSearchInteractor() {
        let tracks = try? interactor.execute().asObservable().toBlocking().single()
        XCTAssertNotNil(tracks)
        XCTAssertGreaterThanOrEqual(tracks?.count ?? 0, 3)
    }
    
}
