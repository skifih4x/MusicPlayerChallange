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
    
}
