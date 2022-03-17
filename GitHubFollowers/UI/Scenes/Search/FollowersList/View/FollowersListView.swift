//
//  FollowersListView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit
import SnapKit

class FollowersListView: UIView {
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = colors.background()
        collection.contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = colors.background()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FollowersListView: ViewCode {
    func buildViewHierarchy() {
       addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
