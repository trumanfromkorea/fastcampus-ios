//
//  PaywallViewController.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

/*
  https://developer.spotify.com/documentation/general/design-and-branding/#using-our-logo
  https://developer.apple.com/documentation/uikit/nscollectionlayoutsectionvisibleitemsinvalidationhandler
  과제: 아래 애플 샘플 코드 다운받아서 돌려보기
 https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views
 */

class PaywallViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!

    let bannerInfos: [BannerInfo] = BannerInfo.list
    let colors: [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed]

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    typealias Item = BannerInfo

    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // presentation - diffable dataSource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
                return nil
            }

            cell.configure(itemIdentifier)
            cell.backgroundColor = self.colors[indexPath.item]

            return cell
        })

        // data - snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(bannerInfos, toSection: .main)
        dataSource.apply(snapshot)

        // layout - compositional layout
        collectionView.collectionViewLayout = layout()
        
        pageControl.numberOfPages = bannerInfos.count
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20

        section.visibleItemsInvalidationHandler = { item, offset, env in
            let index = Int((offset.x / env.container.contentSize.width).rounded(.up))
            self.pageControl.currentPage = index
        }

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}
