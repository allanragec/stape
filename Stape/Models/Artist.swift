//
//  Artist.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  CXopyright © 2018 Allan Melo. All rights reserved.
//

struct Artist: Codable {
    let id: Int64
    let name: String
    let link: String
    let picture: String
    let pictureSmall: String
    let pictureMedium: String
    let pictureBig: String
    let pictureXl: String
    let nbAlbum: Int
    let nbFan: Int64
    let radio: Bool
    let tracklist: String
    let timeAdd: Int64
    var albums: [Album]?
    var musics: [Music]?
}
