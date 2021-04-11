//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit
import SDWebImage

final class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellViewModel : MovieCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.titleText
            
            if let imagePath: String = cellViewModel?.posterPath, let imageURL: URL = URL(string: (imageBaseURL + imagePath)) {
                avatarImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: [], completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
                    self.avatarImageView.image = image
                })
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
