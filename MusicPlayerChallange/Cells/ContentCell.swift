//
//  ContentCell.swift
//  MusicPlayerChallange
//
//  Created by Alexander Altman on 21.09.2022.
//

import UIKit

final class ContentCell: UICollectionViewCell {

    struct ViewModel {
//        let posterURL: String?     дописать после networking model
        let songTitle: String
        let artistLabel: String
        let poster: UIImage   // удалить после networking model
    }
    

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    
    var viewModel: ViewModel! {
        didSet {
//            albumLabel.text = "Black Album"
//            artistLabel.text = "Metallica"
        }
    }
    
    
    func configure(albumeModel: ResultsAlbum) {
        albumLabel.text = albumeModel.collectionName
        artistLabel.text = albumeModel.artistName
        DispatchQueue.global().async {
            guard let url = URL(string: albumeModel.artworkUrl100 ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: imageData)
                self.posterImage.layer.cornerRadius = 10
                self.posterImage.layer.borderWidth = 2
                self.posterImage.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
            }
        }
    }
}

