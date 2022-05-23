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

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true // 알아서 폰트 사이즈 조정
    }

    func configure(_ framework: AppleFramework) {
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
}
