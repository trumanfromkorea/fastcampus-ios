//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import Combine
import UIKit

class SearchViewController: UIViewController {
    let network = NetworkService(configuration: .default)

    @Published private(set) var users: [SearchResult] = []
    var subscriptions = Set<AnyCancellable>()

    @IBOutlet var collectionView: UICollectionView!

    typealias Item = SearchResult
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchControl()
        configureCollectionView()
        bind()
    }

    // searchController
    private func embedSearchControl() {
        navigationItem.title = "Search"

        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
    }

    // collectionView 구성
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCell.identifier, for: indexPath) as? ResultCell else {
                return nil
            }

            cell.user.text = itemIdentifier.login

            return cell
        })

        collectionView.collectionViewLayout = collectionViewLayout()
    }

    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }

    // 데이터 -> 뷰
    //   - 검색된 사용자를 collectionView 업데이트 하는 것
    private func bind() {
        $users
            .receive(on: RunLoop.main)
            .sink { users in
                // collectionView update
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(users, toSection: .main)
                self.dataSource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }

    // - 사용자 인터랙션 대응
    //   - searchControl 에서 텍스트 -> 네트워크 요청
    private func sendRequest(_ keyword: String?) {
        guard let keyword = keyword, !keyword.isEmpty else { return }

        let base = "https://api.github.com/"
        let path = "search/users"
        let params: [String: String] = ["q": keyword]
        let header: [String: String] = ["Content-Type": "application/json"]

        let resource = Resource<SearchUserResponse>(
            base: base, path: path, params: params, header: header
        )

        network
            .load(resource)
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscriptions)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        sendRequest(searchController.searchBar.text)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        sendRequest(searchBar.text)
    }
}
