//
//  GFSelectionTableViewCell.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import UIKit

class GFSelectionTableViewCell: UITableViewCell, Identifier {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 16, y: 0, width: contentView.frame.size.width - 16, height: contentView.frame.size.height)
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        
    }
    
    func setup(with model: SettingsSelectionOption) {
        titleLabel.text = model.title
        accessoryType = model.isActive ? .checkmark : .none
    }
}
