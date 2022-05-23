//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by 장재훈 on 2022/05/23.
//

import UIKit

class FrameworkListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let list: [AppleFramework] = AppleFramework.list
    let HInset: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()

        // data, presentation, layout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationController?.navigationBar.topItem?.title = "🍏 Apple Frameworks"
        
        // estimated size 를 코드로
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = .zero
        }
        
        // 상하좌우 insets
        collectionView.contentInset = UIEdgeInsets(top: 10, left: HInset, bottom: 0, right: HInset)
    }
}

extension FrameworkListViewController: UICollectionViewDelegate {
    // 아이템 선택 시 호출
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item]
        
        print(framework.name)
    }
}

extension FrameworkListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let width = (collectionView.bounds.width - (interItemSpacing * 2 + HInset * 2)) / 3
        let height = width * 1.5

        return CGSize(width: width, height: height)
    }

    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // 상하 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension FrameworkListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrameworkCell.identifier, for: indexPath) as? FrameworkCell else {
            return UICollectionViewCell()
        }

        cell.configure(list[indexPath.item])

        return cell
    }
}
