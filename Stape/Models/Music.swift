//
//  Music.swift
//  Stape
//
//  Created by Allan Melo on 01/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

struct Music: Codable {
    let id: Int64
    let title: String
    let preview: String
    let artist: ShortArtist
    var album: ShortAlbum?
}

struct ShortArtist: Codable {
    let id: Int64
    let name: String
}

struct ShortAlbum: Codable {
    let id: Int64
    let title: String
    let coverMedium: String
    let coverBig: String
}
