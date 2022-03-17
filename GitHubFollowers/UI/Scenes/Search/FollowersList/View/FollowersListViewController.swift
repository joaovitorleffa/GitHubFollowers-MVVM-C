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
    let cellsPerRow: CGFloat = 3
    let cellSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBinds()
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    func setupBinds() {
        viewModel?.followers.bind(closure: { [weak self] followers in
            self?.followerViewModels = followers.map { FollowerViewModel(follower: $0) }
            DispatchQueue.main.async {
                self?.customView.collectionView.reloadData()
            }
        })
    }
}

extension FollowersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CellSize.getSize(for: cellsPerRow,
                            interSpacing: cellSpacing,
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
    
    
}
