//
//  User.swift
//  Stape
//
//  Created by Allan Melo on 04/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

struct User: Codable {
    let id: Int64
    let name: String
    let pictureMedium: String
    let country: String
    let tracklist: String
}
