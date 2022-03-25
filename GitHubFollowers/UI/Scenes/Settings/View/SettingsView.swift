//
//  SettingsView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Colors.background()
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
    }
}
