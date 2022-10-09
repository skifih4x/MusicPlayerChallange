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
    var album = [ResultsAlbum]()
    var collectionId: Int = 0
    var albumNamee: String = ""
    var artistNamee: String = ""
    var trackCount: Int = 0
    var getImage: String? = ""
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    var almobeLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.register(UINib(nibName: C.trackCellNibName, bundle: nil), forCellReuseIdentifier: C.tracksListCellIdentifier)
        
        albumName.text = almobeLabelText
        
#warning ("заполняемость нужными треками")
        fetchSong(songName: "lithium")
        print(collectionId)
        fetchAlbumData(collectionId: collectionId)
        
        albumName.text = albumNamee
        artistName.text = artistNamee
        yearAndTrackQty.text = String(describing: trackCount)
        
        
        guard let url = getImage else { return}
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: URL(string: url)!) else { return }
            DispatchQueue.main.async {
                self.albumCover.image = UIImage(data: data)
            }
        }
        
        
        
    }
    // https://itunes.apple.com/search?term=nevermind&entity=album&attribute=albumTerm
    // https://itunes.apple.com/lookup?upc=1440721439&entity=song
    // https://itunes.apple.com/lookup?id=1169213791&entity=song
    //https://itunes.apple.com/lookup?id=1169213791&entity=musicArtist
    
    private func fetchAlbumData(collectionId: Int) {
        let url = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song"
        NetworkFetch.shared.albumFetch(urlString: url) { albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else {return}
                self.album = albumModel.results
                self.albumTableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }

    
    
    private func fetchSong(songName: String) {
        let urlString = "https://itunes.apple.com/search?entity=song&term=\(songName)"
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
        cell.artistLabel.text = track.artistName
        cell.songLabel.text = track.trackName
        cell.configure(trackModel: track)
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
extension AlbumViewController: TrackMovingDelegate {
func getTrack(isForwardTrack: Bool) -> Tracks? {
    guard let indexPath = albumTableView.indexPathForSelectedRow else { return nil}
    albumTableView.deselectRow(at: indexPath, animated: true)
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
    
    albumTableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
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
