//
//  RepositoriesView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import UIKit
import SnapKit

class RepositoriesView: UIView {
    let loadingView = GFLoadingView()
    let errorView = GFLoadingView()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = colors.background()
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = colors.background()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoadingView(when show: Bool) {
        loadingView.isHidden = !show
    }
    
    func showErrorView(when show: Bool) {
        errorView.isHidden = !show
    }
}

extension RepositoriesView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
    }
}
