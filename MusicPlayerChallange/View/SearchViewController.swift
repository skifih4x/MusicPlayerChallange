//
//  MusicViewController.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 21.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var tracks: [Tracks] = []
//        Tracks(artistName: "Metallica", collectionName: "Black Albom", trackName: "Nothing Else Matters", trackTimeMillis: 210743)
    
    var timer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // text properties for the search bar
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textfield.textColor = UIColor.white
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: C.trackCellNibName, bundle: nil), forCellReuseIdentifier: C.tracksListCellIdentifier)
    }
    
    private func fetchSong(songName: String) {
        let urlString = "https://itunes.apple.com/search?entity=song&term=\(songName)"
        NetworkFetch.shared.songFetch(urlString: urlString) { [weak self] trackModel, error in
            if error == nil {
                guard let trackModel = trackModel else {return}
                self?.tracks = trackModel.results
            } else {
                print(error!.localizedDescription)
            }
        }
        }
    }


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let track = tracks[indexPath.row]
        
//MARK: track length calculation
//        let minsec: Double = round(((Double(track.trackTimeMillis) / 1000) / 60) * 100) / 100.0
//        let min: Int = (track.trackTimeMillis / 1000) / 60
//        let secs = round((round((minsec - Double(min)) * 100) / 100.0) * 60)
//        let length = "\(min):\(Int(secs))"
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.tracksListCellIdentifier, for: indexPath) as! TracksTableViewCell
        NetworkFetch.shared.songFetch(urlString: <#T##String#>, response: <#T##(TrackModel?, Error?) -> Void#>)
        cell.configure(trackModel: <#T##Tracks#>)
//        cell.songLabel.text = track.trackName
//        cell.artistLabel.text = track.artistName
//        cell.songLengthLabel.text = String(length)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //
    //        tableView.reloadData()
    //    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
                self?.fetchSong(songName: searchText)
                self?.tableView.reloadData()
            })
//
//            tableView.reloadData()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
            //        } else {
            //            searchBarSearchButtonClicked(searchBar) // Live search
            //        }
        }
    }
}
