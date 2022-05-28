//
//  SearchViewController.swift
//  InstaSearchView
//
//  Created by 장재훈 on 2022/05/24.
//

import UIKit

enum Section {
    case search
    case home
}

class SearchViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let list: [String] = (1 ... 24).map { "animal\($0)" }

    var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    // data, presentation, layout
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"

        // diffable dataSource
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCell.identifier, for: indexPath) as? ResultCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.search])
        snapshot.appendItems(list, toSection: .search)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = layout()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalWidth(1 / 3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.5, leading: 0.5, bottom: 0.5, trailing: 0.5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1 / 3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let search = searchController.searchBar.text
        print("search: \(search)")
    }
}
