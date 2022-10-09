//
//  AlbumeModelCell.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 09.10.2022.
//

import Foundation

struct AlbumModelCell: Decodable {
    let results: [ResultsAlbumCell]
}

struct ResultsAlbumCell: Decodable {
    let collectionId: Int // id для перехода к трекам альбома
    let artistName: String
    let artworkUrl100: String?
    let trackCount: Int
    let collectionName: String
    let trackTimeMillis: Int?
    let trackName: String?
    let previewUrl: String?
}
