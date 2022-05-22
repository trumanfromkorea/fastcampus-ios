//
//  ChatListCollectionViewCell.swift
//  ChatList
//
//  Created by 장재훈 on 2022/05/22.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChatListCollectionViewCell"

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    func configure(_ chat: Chat) {
        thumbnail.image = UIImage(named: chat.name)
        thumbnail.layer.cornerRadius = 10
        nameLabel.text = chat.name
        chatLabel.text = chat.chat
        dateLabel.text = formattedDateString(chat.date)
    }

    func formattedDateString(_ dateString: String) -> String {
        // 2022-01-01
        // 1/1

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        // String -> Date
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "M/d"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
