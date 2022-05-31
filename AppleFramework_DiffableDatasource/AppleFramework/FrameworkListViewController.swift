//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/04/24.
//

import UIKit

class FrameworkListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let list: [AppleFramework] = AppleFramework.list

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    typealias Item = AppleFramework

    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self

        navigationController?.navigationBar.topItem?.title = "☀️ Apple Frameworks"

        // Data, Presentation, Layout

        // diffable datasource
        // - presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrameworkCell.identifier, for: indexPath) as? FrameworkCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // snapshot
        // - data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)

        // compositional layout
        // - layout
        collectionView.collectionViewLayout = layout()
    }

    // group 은 그리드에서 한줄 한줄,
    // group 내 아이템
    private func layout() -> UICollectionViewCompositionalLayout {
        // fractionalWidth, Height -> 할당된 group 의 사이즈
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // fractional -> section 의 size
        // 높이는 너비의 1/3 쓴것
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}

extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item]
        print(">>> selected: \(framework.name)")

        // 우리가 띄우고 싶은것 FrameworkDetailViewController

        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: FrameworkDetailViewController.identifier) as! FrameworkDetailViewController
        present(vc, animated: true)
    }
}
