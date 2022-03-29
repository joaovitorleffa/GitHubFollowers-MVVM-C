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
    let errorView = GFErrorView(title: Strings.errorViewFollowersTitle())
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = Colors.background()
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collection
    }()
    
    let searchController: UISearchController = {
        let search = UISearchController()
        search.obscuresBackgroundDuringPresentation = false
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
        errorView.isHidden = true
        backgroundColor = Colors.background()
    }
    
    func showLoadingView(when show: Bool) {
        loadingView.isHidden = !show
    }
    
    func showErrorView(when show: Bool) {
        errorView.isHidden = !show
    }
}

extension FollowersListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(collectionView)
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
        loadingView.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalToSuperview()
        }
    }
}
