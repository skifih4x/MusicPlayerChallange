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
            albumLabel.text = "Black Album"
            artistLabel.text = "Metallica"
            
            // для парсинга обложки
//            if let posterURL = viewModel.posterURL {
//                ImageManager.shared.fetchImegeOf(size: .medium, from: posterURL) { image in
//                    self.posterImage.image = image
//                }
//            }
         
        }
    }

}
