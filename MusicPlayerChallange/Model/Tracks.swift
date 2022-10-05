//
//  Tracks.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 25.09.2022.
//

import Foundation

struct TrackModel: Decodable {
    let results: [Tracks]
}

struct Tracks: Decodable {
    let artistName: String
    let collectionName: String
    let trackName: String
    let trackTimeMillis: Int
    let artworkUrl100: String?
}
