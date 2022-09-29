//
//  SearchViewController.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 21.09.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var player: AVPlayer!


    //MARK: - Buttons IBOutlets
    
    @IBOutlet weak var rwButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var ffButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        rwButton.setImage(UIImage(systemName: "backward"), for: UIControl.State.normal)
        rwButton.setImage(UIImage(systemName: "backward.fill"), for: UIControl.State.highlighted)
        
        playButton.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
        playButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.highlighted)
        
        ffButton.setImage(UIImage(systemName: "forward"), for: UIControl.State.normal)
        ffButton.setImage(UIImage(systemName: "forward.fill"), for: UIControl.State.highlighted)
        
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Hello", ofType: "mp3")!))
        slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: DispatchQueue.main) {
            (time) in
            self.labelTime.text = "\(Int(time.seconds))"
            self.slider.value = Float(time.seconds)
        }
    }
    //MARK: - Buttons IBActions
    
    @IBAction func rwButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if player.timeControlStatus == .playing {
            player.pause()
        } else {
            player.play()
        }
    }
    
    @IBAction func ffButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        player.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
        self.labelTime.text = "\(slider.value)"
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

