//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by 장재훈 on 2022/05/31.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    static let identifier = "QuickFocusCell"
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ quickFocus: QuickFocus) {
        thumbnailImageView.image = UIImage(named: quickFocus.imageName)
        titleLabel.text = quickFocus.title
        descriptionLabel.text = quickFocus.description
    }
}
