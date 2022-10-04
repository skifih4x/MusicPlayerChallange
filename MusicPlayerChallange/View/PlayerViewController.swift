//
//  SearchViewController.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 21.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    

    //MARK: - Buttons IBOutlets
    
    @IBOutlet weak var rwButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var ffButton: UIButton!
    
    override func viewDidLoad() {
        rwButton.setImage(UIImage(systemName: "backward"), for: UIControl.State.normal)
        rwButton.setImage(UIImage(systemName: "backward.fill"), for: UIControl.State.highlighted)
        
        playButton.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
        playButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.highlighted)
        
        ffButton.setImage(UIImage(systemName: "forward"), for: UIControl.State.normal)
        ffButton.setImage(UIImage(systemName: "forward.fill"), for: UIControl.State.highlighted)
    }
    
    //MARK: - Buttons IBActions
    
    @IBAction func rwButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func ffButtonPressed(_ sender: UIButton) {
    }
}
