//
//  TrackModel.swift
//  MusicPlayerChallange
//
//  Created by Марк Михайлов on 04.10.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// MARK: - Result
struct Music: Codable {
    let wrapperType: WrapperType
    let collectionType: String?
    let artistID, collectionID: Int
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: Name
    let artistViewURL, collectionViewURL: String
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double
    let collectionExplicitness: Explicitness
    let trackCount: Int
    let copyright: String?
    let country: Country
    let currency: Currency
    let releaseDate: String
    let primaryGenreName: PrimaryGenreName
    let kind: Kind?
    let trackID: Int?
    let trackName, trackCensoredName: String?
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30: String?
    let trackPrice: Double?
    let trackExplicitness: Explicitness?
    let discCount, discNumber, trackNumber, trackTimeMillis: Int?
    let isStreamable: Bool?

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName, kind
        case trackID = "trackId"
        case trackName, trackCensoredName
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, trackPrice, trackExplicitness, discCount, discNumber, trackNumber, trackTimeMillis, isStreamable
    }
}

enum Name: String, Codable {
    case weezer = "Weezer"
    case weezerDeluxeEdition = "Weezer (Deluxe Edition)"
}

enum Explicitness: String, Codable {
    case notExplicit = "notExplicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case song = "song"
}

enum PrimaryGenreName: String, Codable {
    case pop = "Pop"
    case rock = "Rock"
}

enum WrapperType: String, Codable {
    case collection = "collection"
    case track = "track"
}
