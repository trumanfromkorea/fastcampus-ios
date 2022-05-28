//
//  HomeViewController.swift
//  InstaSearchView
//
//  Created by 장재훈 on 2022/05/25.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let list: [String] = (1 ... 24).map { "animal\($0)" }

    var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // diffable datasource
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.home])
        snapshot.appendItems(list, toSection: .home)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = layout()
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitem: item, count: 1)

        group.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}
