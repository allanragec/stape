//
//  GetUserInteractorTest.swift
//  StapeTests
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Stape

class GetUserInteractorTest: XCTestCase {
    
    let interactor = GetUserInteractor(userId: 2401111128)
    
    func testGetAlbumsInteractor() {
        let user = try? interactor.execute().asObservable().toBlocking().single()
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, 2401111128)
    }
    
}

