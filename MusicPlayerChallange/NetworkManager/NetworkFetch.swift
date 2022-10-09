//
//  NetworkFetch.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 29.09.2022.
//

import Foundation

struct NetworkFetch {
    
    static let shared = NetworkFetch()
    
    func albumeFetchRammstein(completion: @escaping (Result<AlbumModel, Error> ) -> Void ) {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=rammstein&entity=album&attribute=albumTerm") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(AlbumModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func albumeFetchSystem(completion: @escaping (Result<AlbumModel, Error> ) -> Void ) {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=system-of-a-down&entity=album&attribute=albumTerm") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(AlbumModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func songFetch(urlString: String, response: @escaping (TrackModel?, Error?) -> Void) {
        DataFetch.shared.fetchData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(TrackModel.self, from: data)
                    response(results, nil )
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error fetching song data: \(error.localizedDescription)")
                response(nil, error )
            }
        }
    }
    
    
    func albumFetch(urlString: String, response: @escaping (AlbumModelCell?, Error?) -> Void) {
        DataFetch.shared.fetchData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(AlbumModelCell.self, from: data)
                    response(results, nil )
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error fetching song data: \(error.localizedDescription)")
                response(nil, error )
            }
        }
    }
    
    
    
}
