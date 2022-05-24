//
//  ResultCell.swift
//  InstaSearchView
//
//  Created by 장재훈 on 2022/05/24.
//

import UIKit

class ResultCell: UICollectionViewCell {
    static let identifier = "ResultCell"

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
