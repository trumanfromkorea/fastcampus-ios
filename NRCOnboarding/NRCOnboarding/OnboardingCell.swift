//
//  OnboardingCell.swift
//  NRCOnboarding
//
//  Created by 장재훈 on 2022/05/26.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    static let identifier = "OnboardingCell"

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    func conifigure(_ message: OnboardingMessage) {
        thumbnailImageView.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        descriptionLabel.text = message.description
    }
}
