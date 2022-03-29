//
//  FavoritesListView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import UIKit
import SnapKit

class FavoritesListView: UIView {
    let loadingView = GFLoadingView()
    let errorView = GFErrorView(title: Strings.favoritesListViewError())
    let emptyView = GFErrorView(title: Strings.favoritesListViewEmpty())

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Colors.background()
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        errorView.isHidden = true
        emptyView.isHidden = true
        backgroundColor = Colors.background()
    }
    
    func showLoadingView(when show: Bool) {
        loadingView.isHidden = !show
    }
    
    func showErrorView(when show: Bool) {
        errorView.isHidden = !show
    }
    
    func showEmptyView(when show: Bool) {
        emptyView.isHidden = !show
    }
}

extension FavoritesListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(errorView)
        addSubview(emptyView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.centerX.centerY.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.centerX.centerY.equalToSuperview()
        }
        emptyView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.centerX.centerY.equalToSuperview()
        }
    }
}
