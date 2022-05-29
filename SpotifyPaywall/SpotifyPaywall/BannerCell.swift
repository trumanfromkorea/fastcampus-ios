//
//  BannerCell.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
    }

    func configure(_ info: BannerInfo) {
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        thumbnailImageView.image = UIImage(named: info.imageName)
    }
}
