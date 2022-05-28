//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 장재훈 on 2022/05/28.
//

import UIKit

class FocusViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    typealias Item = Focus

    enum Section {
        case main
    }

    var items: [Focus] = Focus.list
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsVerticalScrollIndicator = false

        // datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FocusCell.identifier, for: indexPath) as? FocusCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = layout()
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        // estimated -> 그냥 예상... 근데 컨텐츠에 따라 변경될 수 있다
        // absolute -> 고정크기
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}
