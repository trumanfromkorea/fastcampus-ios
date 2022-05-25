//
//  HomeViewController.swift
//  InstaSearchView
//
//  Created by 장재훈 on 2022/05/25.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // data, presentation, layout
        collectionView.delegate = self
        collectionView.dataSource = self

        // cell 크기 지정하는대로 출력하기 위함
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = .zero
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = width

        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }

        let imageName = "animal\(indexPath.item + 1)"
        cell.configure(imageName)

        return cell
    }
}
