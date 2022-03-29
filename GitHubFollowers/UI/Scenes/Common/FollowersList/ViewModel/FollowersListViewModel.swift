//
//  FollowersListViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation

protocol FollowersListViewModelProtocol: AnyObject {
    var username: String { get }
    
    var isError: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var followers: Observable<[Follower]> { get }
    
    func reloadData()
    func fetchFollowers()
    func filter(by text: String)
    func addUserToFavorites()
    func didTapUser(username: String)
}

class FollowersListViewModel: FollowersListViewModelProtocol {
    var username: String
    var requester: RequesterProtocol
    var favoriteManager: FavoriteManagerProtocol
    weak var coordinator: (FollowersFlux & AlertFlux)?
    
    private(set) var isError: Observable<Bool> = Observable(false)
    private(set) var isLoading: Observable<Bool> = Observable(true)
    private(set) var followers: Observable<[Follower]> = Observable([])
    
    private var currentPage = 1
    private var loadedAll: Bool = false
    private var allFollowers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    
    init(username: String,
         coordinator: (FollowersFlux & AlertFlux),
         requester: RequesterProtocol = Requester(),
         favoriteManager: FavoriteManagerProtocol = FavoriteManager()) {
        self.username = username
        self.requester = requester
        self.coordinator = coordinator
        self.favoriteManager = favoriteManager
        
        fetchFollowers()
    }
    
    func fetchFollowers() {
        if loadedAll { return }
        isLoading.value = true
        
        requester.request(from: URLProvider(endpoint: .followers(username: username, page: currentPage))) { [weak self] (result: Result<[Follower], RequesterError>) in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                
                if data.isEmpty {
                    self.loadedAll = true
                } else {
                    self.allFollowers.append(contentsOf: data)
                    self.followers.value = self.allFollowers
                    self.currentPage += 1
                }
                self.isLoading.value = false
            case .failure(let error):
                print("[fetchFollowers] \(error.localizedDescription)")
                self?.isLoading.value = false
                self?.isError.value = true
            }
        }
    }
    
    func filter(by text: String) {
        followers.value = allFollowers.filter { $0.login.lowercased().contains(text.lowercased()) }
    }
    
    func reloadData() {
        followers.value = allFollowers
    }
    
    func addUserToFavorites() {
        requester.request(from: URLProvider(endpoint: .user(username: username))) { [weak self] (result: Result<User, RequesterError>) in
            switch result {
            case .success(let user):
                self?.handleAddUserToFavorites(user)
            case .failure(let error):
                print("[addToFavorites] \(error.localizedDescription)")
            }
        }
    }
    
    func didTapUser(username: String) {
        coordinator?.goToProfile(by: username)
    }
    
    private func handleAddUserToFavorites(_ user: User) {
        let favoriteToSave = FavoriteToSave(id: user.id,
                                            name: user.name ?? "",
                                            username: user.login.replacingOccurrences(of: "@", with: ""),
                                            avatarURL: user.avatarURL)
        
        favoriteManager.saveFavorite(favoriteToSave) { (result: Result<Favorite, CoreDataError>) in
            switch result {
            case .success:
                NotificationCenter.default.post(name: .updatedFavorites, object: nil)
                DispatchQueue.main.async {
                    self.coordinator?.showAlert(title: Strings.commonSuccess(),
                                                message: Strings.followersListViewAddToFavoritesSuccessMessage(),
                                                buttonTitle: Strings.commonNice())
                }
            case .failure(let error):
                var title = Strings.commonError()
                var message = Strings.followersListViewAddToFavoritesErrorMessage()
                
                switch error {
                case .alreadyExists:
                    title = Strings.commonHey()
                    message = Strings.followersListViewAddToFavoritesAlreadyExistsMessage(user.name ?? Strings.commonUser())
                default: break
                }
                
                DispatchQueue.main.async {
                    self.coordinator?.showAlert(title: title, message: message, buttonTitle: Strings.commonOk())
                }
            }
        }
    }
}
