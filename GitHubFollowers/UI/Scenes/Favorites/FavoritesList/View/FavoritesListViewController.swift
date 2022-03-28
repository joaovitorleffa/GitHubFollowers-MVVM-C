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
    }
    
    func setupBinds() {
        viewModel?.favorites.bind { [weak self] favorites in
            DispatchQueue.main.async {
                self?.customView.showEmptyView(when: favorites.isEmpty)
                if !favorites.isEmpty {
                    self?.favoriteViewModels = favorites.map { FavoriteViewModel(avatarURL: $0.avatarURL!, name: $0.name!) }
                    self?.customView.tableView.reloadData()
                }
            }
        }
        
        viewModel?.isLoading.bind { [weak self] isLoading in
            self?.customView.showLoadingView(when: isLoading)
        }
        
        viewModel?.isError.bind { [weak self] isError in
            self?.customView.showErrorView(when: isError)
        }
    }
}

// MARK: - Delegates
extension FavoritesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
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
