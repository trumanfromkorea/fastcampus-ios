//
//  FrameworkCell.swift
//  AppleFramework
//
//  Created by 장재훈 on 2022/05/23.
//

import UIKit

class FrameworkCell: UICollectionViewCell {
    static let identifier = "FrameworkCell"

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    func configure(_ framework: AppleFramework) {
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
}
