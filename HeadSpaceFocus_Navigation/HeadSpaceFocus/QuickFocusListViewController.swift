//
//  QuickFocusListViewController.swift
//  HeadSpaceFocus
//
//  Created by 장재훈 on 2022/05/31.
//

import UIKit

class QuickFocusListViewController: UIViewController {
    static let identifier = "QuickFocusListViewController"
    static let storyboard = "QuickFocus"

    @IBOutlet var collectionView: UICollectionView!

    let breathingList = QuickFocus.breathing
    let walkingList = QuickFocus.walking

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    typealias Item = QuickFocus

    enum Section: CaseIterable {
        case breathe
        case walk

        var title: String {
            switch self {
            case .breathe: return "Breathing exercises"
            case .walk: return "Mindful walks"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickFocusCell.identifier, for: indexPath) as? QuickFocusCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // Header
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuickFocusHeaderView.identifier, for: indexPath) as? QuickFocusHeaderView else {
                return nil
            }

            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)

            return header
        }

        // data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(breathingList, toSection: .breathe)
        snapshot.appendItems(walkingList, toSection: .walk)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = layout()
        
        // title type
        self.navigationItem.largeTitleDisplayMode = .never
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 20)
        section.interGroupSpacing = 20

        // header layout
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}
