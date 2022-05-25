//
//  HomeCell.swift
//  InstaSearchView
//
//  Created by 장재훈 on 2022/05/25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    static let identifier = "HomeCell"

    @IBOutlet var thumbnailImageView: UIImageView!

    // 재사용 되기전에 준비
    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailImageView.image = nil
    }

    func configure(_ imageName: String) {
        thumbnailImageView.image = UIImage(named: imageName)
    }
}
