//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 장재훈 on 2022/05/28.
//

import UIKit

class FocusViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var refreshButton: UIButton!

    typealias Item = Focus

    enum Section {
        case main
    }

    var curated: Bool = false
    var items: [Focus] = Focus.list
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.showsVerticalScrollIndicator = false
        refreshButton.layer.cornerRadius = 10

        // datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FocusCell.identifier, for: indexPath) as? FocusCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // data
        updateSnapshot()

        // layout
        collectionView.collectionViewLayout = layout()

        updateButtonTitle()
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

    func updateButtonTitle() {
        let title = curated ? "See All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }

    @IBAction func refreshButtonTapped(_ sender: Any) {
        curated.toggle()
        items = curated ? Focus.recommendations : Focus.list

        updateSnapshot()
        updateButtonTitle()
    }
}
