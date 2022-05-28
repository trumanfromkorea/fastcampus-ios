//
//  FocusCell.swift
//  HeadSpaceFocus
//
//  Created by 장재훈 on 2022/05/28.
//

import UIKit

class FocusCell: UICollectionViewCell {
    static let identifier = "FocusCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .systemIndigo
        contentView.layer.cornerRadius = 10
    }

    func configure(_ item: Focus) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        thumbnailImageView.image = UIImage(systemName: item.imageName)?.withRenderingMode(.alwaysOriginal)
    }
}
