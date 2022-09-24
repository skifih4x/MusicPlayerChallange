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
    
    let tracks: [Tracks] = [
        Tracks(artistName: "Metallica", trackName: "Nothing Else Matters", length: "5:12"),
        Tracks(artistName: "Nirvana", trackName: "Smells Like Teen Spirit", length: "3:38"),
        Tracks(artistName: "Tool", trackName: "The Pot", length: "7:35"),
        Tracks(artistName: "Metallica", trackName: "Nothing Else Matters", length: "5:12"),
        Tracks(artistName: "Nirvana", trackName: "Smells Like Teen Spirit", length: "3:38"),
        Tracks(artistName: "Tool", trackName: "The Pot", length: "7:35"),
        Tracks(artistName: "Metallica", trackName: "Nothing Else Matters", length: "5:12"),
        Tracks(artistName: "Nirvana", trackName: "Smells Like Teen Spirit", length: "3:38"),
        Tracks(artistName: "Tool", trackName: "The Pot", length: "7:35"),
        Tracks(artistName: "Metallica", trackName: "Nothing Else Matters", length: "5:12"),
        Tracks(artistName: "Nirvana", trackName: "Smells Like Teen Spirit", length: "3:38"),
        Tracks(artistName: "Tool", trackName: "The Pot", length: "7:35"),
        Tracks(artistName: "Metallica", trackName: "Nothing Else Matters", length: "5:12"),
        Tracks(artistName: "Nirvana", trackName: "Smells Like Teen Spirit", length: "3:38"),
        Tracks(artistName: "Tool", trackName: "The Pot", length: "7:35")]
    
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
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let track = tracks[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.tracksListCellIdentifier, for: indexPath) as! TracksTableViewCell
        cell.songLabel.text = track.trackName
        cell.artistLabel.text = track.artistName
        cell.songLengthLabel.text = track.length
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
