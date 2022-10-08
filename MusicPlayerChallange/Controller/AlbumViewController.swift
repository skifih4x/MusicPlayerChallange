//
//  AlbumViewController.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 04.10.2022.
//

import UIKit

class AlbumViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var yearAndTrackQty: UILabel!
    @IBOutlet weak var albumTableView: UITableView!
    
    //MARK: - Variables & Constants
    var tracks = [Tracks]()
    var collectionId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.register(UINib(nibName: C.trackCellNibName, bundle: nil), forCellReuseIdentifier: C.tracksListCellIdentifier)
        
//        albumName.text =
//        artistName.text =
//        albumCover.image =
//        yearAndTrackQty.text =
        
    }
    // https://itunes.apple.com/search?term=nevermind&entity=album&attribute=albumTerm
    // https://itunes.apple.com/lookup?upc=778360335&entity=song
    private func fetchAlbum(collectionId: Int) {
        let urlString = "https://itunes.apple.com/search?entity=song&term=\(collectionId)"
        print(urlString)
        NetworkFetch.shared.songFetch(urlString: urlString) { [weak self] trackModel, error in
            if error == nil {
                guard let trackModel = trackModel else {return}
                self?.tracks = trackModel.results
                self?.albumTableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }    
}

//MARK: - Extensions
extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.tracksListCellIdentifier, for: indexPath) as! TracksTableViewCell
        let track = tracks[indexPath.row]
        cell.configure(trackModel: track)
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
