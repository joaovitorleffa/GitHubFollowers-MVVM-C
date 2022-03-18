//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

class FollowersListViewController: BaseViewController<FollowersListView> {
    var viewModel: FollowerListViewModelProtocol?
    var followerViewModels: [FollowerViewModelProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCollectionView()
        setupBinds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupNavigationController() {
        title = viewModel?.username
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = customView.searchController
        customView.searchController.delegate = self
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    func setupBinds() {
        viewModel?.followers.bind(closure: { [weak self] followers in
            self?.followerViewModels = followers.map { item in FollowerViewModel(follower: item) {
                self?.viewModel?.coordinator?.goToProfile(by: item.login)
            }}
            DispatchQueue.main.async {
                self?.customView.collectionView.reloadData()
            }
        })
        
        viewModel?.isLoading.bind(closure: { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.customView.showLoadingView(when: !isLoading)
            }
        })
    }
}

extension FollowersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CellSize.getSize(for: Constants.cellsPerRow,
                            interSpacing: Constants.cellSpacing,
                            insets: collectionView.contentInset,
                            collectionViewWidth: collectionView.bounds.size.width)
    }
}

extension FollowersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        followerViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as? FollowerCell else {
            fatalError("[cellForItemAt] create cell error")
        }
        
        let viewModel = followerViewModels[indexPath.row]
        cell.setup(viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        followerViewModels[indexPath.row].goToProfile?()
    }
}

extension FollowersListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let shouldRefreshPosition = customView.collectionView.contentSize.height - Constants.shouldRefresh - scrollView.frame.size.height
        if position > shouldRefreshPosition {
            if viewModel?.isLoading.value == false {
                viewModel?.fetchFollowers()
            }
        }
    }
}

extension FollowersListViewController: UISearchControllerDelegate {

}

extension FollowersListViewController {
    struct Constants {
        static let cellsPerRow: CGFloat = 3
        static let cellSpacing: CGFloat = 10
        static let shouldRefresh: CGFloat = 100
    }
}
