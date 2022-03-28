//
//  FavoritesListViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import Foundation

protocol FavoritesListViewModelProtocol: AnyObject {
    var favorites: Observable<[Favorite]> { get }
    var isLoading: Observable<Bool> { get }
    var isError: Observable<Bool> { get }
}

class FavoritesListViewModel: FavoritesListViewModelProtocol {
    var favorites: Observable<[Favorite]> = Observable([])
    var isLoading: Observable<Bool> = Observable(true)
    var isError: Observable<Bool> = Observable(false)
    
    private var favoriteManager: FavoriteManagerProtocol
    
    init(favoriteManager: FavoriteManagerProtocol = FavoriteManager()) {
        self.favoriteManager = favoriteManager
        fetchFavorites()
    }
    
    func fetchFavorites() {
        favoriteManager.fetchFavorites { [weak self] (result: Result<[Favorite], CoreDataError>) in
            switch result {
            case .success(let favorites):
                self?.favorites.value = favorites
                self?.isLoading.value = false
            case .failure(let error):
                print("[fetchFavorites] \(error.localizedDescription)")
                self?.isLoading.value = false
                self?.isError.value = true
            }
        }
    }
}
