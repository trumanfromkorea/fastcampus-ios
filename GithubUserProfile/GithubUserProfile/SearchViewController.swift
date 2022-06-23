//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import Combine
import UIKit
// import Kingfisher

class UserProfileViewController: UIViewController {
    // Setup UI
    // User Profile
    // Bind -> update ui
    // Search Control -> network
    // Network

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
        thumbnail.image = nil
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

        let base = "https://api.github.com"
        let path = "/users/\(keyword)"
        let params: [String: String] = [:]
        let header: [String: String] = ["Content-Type": "application/json"]

        var urlComponents = URLComponents(string: base + path)!
        
        // query 추가
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems

        // header 추가
        var request = URLRequest(url: urlComponents.url!)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                // statusCode 검사
                guard let response = result.response as? HTTPURLResponse,
                      (200 ..< 300).contains(response.statusCode) else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: UserProfile.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion: \(completion)")
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &subscriptions)

    }
}
