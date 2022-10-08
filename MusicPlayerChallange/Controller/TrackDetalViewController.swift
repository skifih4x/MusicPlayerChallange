//
//  TrackDetalViewController.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 06.10.2022.
//

import UIKit
import AVKit

protocol TrackMovingDelegate: AnyObject {
    func moveBack() -> Tracks?
    func moveNext() -> Tracks?
}

class TrackDetalViewController: UIView {
    
    @IBOutlet weak var rwButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var ffButton: UIButton!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var tracks = [Tracks]()

    
    var player: AVPlayer = {
        var avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    weak var delegate: TrackMovingDelegate?
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rwButton.setImage(UIImage(systemName: "backward"), for: UIControl.State.normal)
        rwButton.setImage(UIImage(systemName: "backward.fill"), for: UIControl.State.highlighted)

        ffButton.setImage(UIImage(systemName: "forward"), for: UIControl.State.normal)
        ffButton.setImage(UIImage(systemName: "forward.fill"), for: UIControl.State.highlighted)
    }
    
    func set(viewModel: Tracks) {
        trackTitleLabel.text = viewModel.trackName
        authorTitleLabel.text = viewModel.artistName
        let string600 = viewModel.artworkUrl100?.replacingOccurrences(of: "100x100", with: "350x350")
        guard let url = URL(string: string600 ?? "") else { return }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.trackImageView.image = UIImage(data: data)
            }
        }
        playTrack(previewUrl: viewModel.previewUrl)
        observePlayerTime()
        updateCurrentTime()
    }
    func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    @IBAction func rwButtonPressed(_ sender: UIButton) {
        let cellViewModel = delegate?.moveBack()
        guard let cellInfo = cellViewModel else { return }
        set(viewModel: cellInfo)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
        } else {
            player.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func ffButtonPressed(_ sender: UIButton) {
        let cellViewModel = delegate?.moveNext()
        guard let cellInfo = cellViewModel else { return }
        set(viewModel: cellInfo)
    }
    
    @IBAction func sliderAction(_ sender: Any)  {
        let percentage = slider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeUnSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeUnSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    @IBAction func handlerVolumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    func observePlayerTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.labelTime.text = time.toDisplayString()
            
            let durationTime = self?.player.currentItem?.duration
            let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self?.durationTime.text = "-\(currentDurationText)"
            self?.updateCurrentTime()
        }
    }
    
    func updateCurrentTime() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.slider.value = Float(percentage)
    }
    
    @IBAction func drugDownPressed(_ sender: Any) {
        tabBarDelegate?.minimazeTrackDetailController()
        self.removeFromSuperview()
        print("хуй")
    }
}
