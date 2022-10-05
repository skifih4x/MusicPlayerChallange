//
//  SearchViewController.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 21.09.2022.
//

import UIKit
import AVKit

protocol TrackMovingDelegate: class {
    func moveBack() -> SearchViewController
    func moveNext()
}

class PlayerViewController: UIViewController {
    
   


    //MARK: - Buttons IBOutlets
    
    @IBOutlet weak var rwButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var ffButton: UIButton!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    var player: AVPlayer = {
        var avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var playerItem: AVPlayerItem?
    
    
    override func viewDidLoad() {
        
        rwButton.setImage(UIImage(systemName: "backward"), for: UIControl.State.normal)
        rwButton.setImage(UIImage(systemName: "backward.fill"), for: UIControl.State.highlighted)
        
        ffButton.setImage(UIImage(systemName: "forward"), for: UIControl.State.normal)
        ffButton.setImage(UIImage(systemName: "forward.fill"), for: UIControl.State.highlighted)
        
        //player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Hello", ofType: "mp3")!))
        
        let url = URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/07/13/1f/07131fb9-b212-a859-ac10-f1eeb0ff4521/mzaf_6095673758554747946.plus.aac.p.m4a")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)

        observePlayerTime()
    }
    
    
    //MARK: - Buttons IBActions
    
    @IBAction func rwButtonPressed(_ sender: UIButton) {
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
    }
    
    @IBAction func sliderAction(_ sender: Any) {
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
    }
}

