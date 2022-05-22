//
//  ChatListViewController.swift
//  ChatList
//
//  Created by 장재훈 on 2022/05/21.
//

import UIKit

class ChatListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let chatList: [Chat] = Chat.list.sorted(by: { $0.date > $1.date })

    override func viewDidLoad() {
        super.viewDidLoad()

        // data, presentation, layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ChatListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}

extension ChatListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatListCollectionViewCell.identifier, for: indexPath) as? ChatListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(Chat.list[indexPath.item])

        return cell
    }
}
