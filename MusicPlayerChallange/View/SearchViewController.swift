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
    
    var tracks = [Tracks]()
    var timer: Timer?
    var playerView = PlayerViewController()
    weak var tabBarDelegate: MainTabBarControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // text properties for the seaxrch bar
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textfield.textColor = UIColor.white
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: C.trackCellNibName, bundle: nil), forCellReuseIdentifier: C.tracksListCellIdentifier)
        searchBar.delegate = self
    }
    
    private func fetchSong(songName: String) {
        let urlString = "https://itunes.apple.com/search?entity=song&term=\(songName)"
        print(urlString)
        NetworkFetch.shared.songFetch(urlString: urlString) { [weak self] trackModel, error in
            if error == nil {
                guard let trackModel = trackModel else {return}
                self?.tracks = trackModel.results
                self?.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: C.tracksListCellIdentifier, for: indexPath) as! TracksTableViewCell
        let track = tracks[indexPath.row]
        cell.artistLabel.text = track.artistName
        cell.songLabel.text = track.trackName
        
        cell.configure(trackModel: track)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        print("cellViewModel.trackName:", track.trackName)
        
                let window = UIApplication.shared.keyWindow
                let trackDetailsView = Bundle.main.loadNibNamed("TrackDetailView", owner: self)?.first as! TrackDetalViewController
                trackDetailsView.set(viewModel: track)
                trackDetailsView.delegate = self
                window?.addSubview(trackDetailsView)
        
//                let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
//                self.navigationController?.pushViewController(vc!, animated: true)
        tabBarDelegate?.maximazeTrackDetailController(viewModel: track )
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.placeholder = "Search"
        if searchText != ""  {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchSong(songName: searchText)
            })
        }
    }
}

extension SearchViewController: TrackMovingDelegate {
    
    func getTrack(isForwardTrack: Bool) -> Tracks? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil}
        tableView.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isForwardTrack {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == tracks.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = tracks.count - 1
            }
        }
        
        tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = tracks[indexPath.row]
        print(cellViewModel.trackName)
        return cellViewModel
    }
    
    func moveBack() -> Tracks? {
        print("go back")
        return getTrack(isForwardTrack: false)
    }
    
    func moveNext() -> Tracks? {
        print("go forward")
        return getTrack(isForwardTrack: true)
    }
    
    
}
