//
//  AlbumModel.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 22.09.2022.
//

import Foundation

struct AlbumModel: Decodable {
    let results: [ResultsAlbum]
}

struct ResultsAlbum: Decodable {
    let collectionId: Int // id для перехода к трекам альбома
    let artistName: String
    let artworkUrl100: String?
    let trackCount: Int
    let collectionName: String
    
}
