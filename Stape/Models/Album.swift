//
//  Album.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

struct Album: Codable {
    let id: Int64
    let title: String
    let link: String
    let cover: String
    let coverSmall: String
    let coverMedium: String
    let coverBig: String
    let genreId: Int
    let fans: Int64
    let releaseDate: String
    let recordType: String
    let tracklist: String
    let explicitLyrics: Bool
}
