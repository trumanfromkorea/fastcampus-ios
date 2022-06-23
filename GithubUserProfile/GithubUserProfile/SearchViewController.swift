//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import Combine
import Kingfisher
import UIKit

class UserProfileViewController: UIViewController {
    // Setup UI
    // User Profile
    // Bind -> update ui
    // Search Control -> network
    // Network

    let network = NetworkService(configuration: .default)

    // private(set) -> set 은 private, 외부에서 get 은 가능
    @Published private(set) var user: UserProfile?
    var subscriptions = Set<AnyCancellable>()

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var followerLabel: UILabel!
    @IBOutlet var followingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        embedSearchControl()
        bind()
    }

    private func setupUI() {
        thumbnail.layer.cornerRadius = thumbnail.bounds.size.width / 2
    }

    private func embedSearchControl() {
        navigationItem.title = "Search"

        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "trumanfromkorea"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
    }

    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }
            .store(in: &subscriptions)
    }

    private func update(_ user: UserProfile?) {
        guard let user = user else {
            nameLabel.text = "N/A"
            loginLabel.text = "N/A"
            followerLabel.text = ""
            followingLabel.text = ""
            thumbnail.image = nil

            return
        }
        nameLabel.text = user.name
        loginLabel.text = user.login
        followerLabel.text = "followers \(user.followers)"
        followingLabel.text = "following \(user.following)"

        // image url
        // url -> image

        thumbnail.kf.setImage(with: user.avatarUrl)
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text

        print(keyword)
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }

        let resource = Resource<UserProfile>(
            base: "https://api.github.com/",
            path: "users/\(keyword)",
            params: [:],
            header: ["Content-Type": "application/json"]
        )

        // Network Service
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.user = nil
                case .finished:
                    break
                }
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &subscriptions)
    }
}
