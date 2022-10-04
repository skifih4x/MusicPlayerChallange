//
//  TracksTableViewCell.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 25.09.2022.
//

import UIKit

class TracksTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        albumCover.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(trackModel: Tracks) {
        let minsec: Double = round(((Double(trackModel.trackTimeMillis) / 1000) / 60) * 100) / 100.0
        let min: Int = (trackModel.trackTimeMillis / 1000) / 60
        let secs = round((round((minsec - Double(min)) * 100) / 100.0) * 60)
        let length = "\(min):\(Int(secs))"
        
        
        songLabel.text = trackModel.trackName
        artistLabel.text = trackModel.artistName
        songLengthLabel.text = length
        
        
        
        DispatchQueue.global().async {
            guard let url = URL(string: trackModel.artworkUrl100 ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.albumCover.image = UIImage(data: imageData)
                self.albumCover.layer.cornerRadius = 10
                self.albumCover.layer.borderWidth = 2
                self.albumCover.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
            }
        }
    }
}
