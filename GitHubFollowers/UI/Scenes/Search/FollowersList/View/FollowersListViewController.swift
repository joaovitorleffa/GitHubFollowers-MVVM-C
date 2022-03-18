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
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

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
        customView.searchController.searchBar.delegate = self
        customView.searchController.searchResultsUpdater = self
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
        configureDataSource()
    }
    
    func setupBinds() {
        viewModel?.followers.bind(closure: { [weak self] followers in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.followerViewModels = followers.map { item in FollowerViewModel(follower: item) {
                    self.viewModel?.coordinator?.goToProfile(by: item.login)
                }}
                self.updateUI()
            }
        })
        
        viewModel?.isLoading.bind(closure: { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.customView.showLoadingView(when: !isLoading)
            }
        })
    }
}

// MARK: - CollectionView data source
extension FollowersListViewController {
    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: customView.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.setup(viewModel: self.followerViewModels[indexPath.row])
            return cell
        })
    }

    func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel?.followers.value ?? [], toSection: .main)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - CollectionView delegate
extension FollowersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CellSize.getSize(for: Constants.cellsPerRow,
                            interSpacing: Constants.cellSpacing,
                            insets: collectionView.contentInset,
                            collectionViewWidth: collectionView.bounds.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        followerViewModels[indexPath.row].goToProfile?()
    }
}

// MARK: - ScrollView delegate
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

// MARK: - SearchBar
extension FollowersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        !text.isEmpty ? viewModel?.filter(by: text) : viewModel?.reloadData()
    }
}

extension FollowersListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.reloadData()
    }
}

extension FollowersListViewController {
    struct Constants {
        static let cellsPerRow: CGFloat = 3
        static let cellSpacing: CGFloat = 10
        static let shouldRefresh: CGFloat = 100
    }
}

extension FollowersListViewController {
    enum Section {
        case main
    }
}
