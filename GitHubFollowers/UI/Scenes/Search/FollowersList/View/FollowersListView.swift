//
//  FollowersListView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit
import SnapKit

class FollowersListView: UIView {
    let loadingView = GFLoadingView()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = colors.background()
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collection
    }()
    
    let searchController: UISearchController = {
        let search = UISearchController()
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.barStyle = .black
        search.searchBar.autocapitalizationType = .none
        search.searchBar.autocorrectionType = .no
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        loadingView.isHidden = true
        backgroundColor = colors.background()
    }
    
    func showLoadingView(when show: Bool) {
        loadingView.isHidden = show
    }
}

extension FollowersListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(collectionView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
        loadingView.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalToSuperview()
        }
    }
}
