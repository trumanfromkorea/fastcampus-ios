//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 장재훈 on 2022/05/31.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
    static let identifier = "QuickFocusHeaderView"

    @IBOutlet var titleLabel: UILabel!

    func configure(_ title: String) {
        titleLabel.text = title
    }
}
