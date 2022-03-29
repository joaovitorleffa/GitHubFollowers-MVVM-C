//
//  FavoritesListViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

class FavoritesListViewController: BaseViewController<FavoritesListView> {
    var viewModel: FavoritesListViewModelProtocol?
    var favoriteViewModels: [FavoriteViewModelProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBinds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configure() {
        title = Strings.favoritesListViewTitle()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onUpdatedFavorites),
                                               name: .updatedFavorites,
                                               object: nil)
    }
    
    func setupBinds() {
        viewModel?.favorites.bind { favorites in
            DispatchQueue.main.async { [weak self] in
                self?.favoriteViewModels = favorites.map { FavoriteViewModel(avatarURL: $0.avatarURL!, name: $0.name!) }
                self?.customView.showEmptyView(when: favorites.isEmpty)
                self?.customView.tableView.reloadData()
            }
        }
        
        viewModel?.isLoading.bind { [weak self] isLoading in
            self?.customView.showLoadingView(when: isLoading)
        }
        
        viewModel?.isError.bind { [weak self] isError in
            self?.customView.showErrorView(when: isError)
        }
    }
    
    @objc func onUpdatedFavorites() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.fetchFavorites()
        }
    }
}

// MARK: - Delegates
extension FavoritesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didTapFavorite(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            self.viewModel?.deleteFavorite(indexPath: indexPath)
            completion(true)
        }
        
        action.backgroundColor = .systemRed
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
}

// MARK: - DataSource
extension FavoritesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell
        cell.setup(viewModel: favoriteViewModels[indexPath.row])
        return cell
    }
}
