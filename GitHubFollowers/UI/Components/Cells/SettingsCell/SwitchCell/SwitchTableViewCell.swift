//
//  SwitchTableViewCell.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import UIKit

class SwitchTableViewCell: UITableViewCell, Identifier {
    var switchHandler: (() -> Void)?
    
    let containerIconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.numberOfLines = 1
        return label
    }()
    
    let switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = .systemGreen
        return switchView
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
        let marginTop: CGFloat = 7
        let marginY: CGFloat = marginTop * 2
        let marginX: CGFloat = 16
        
        let size: CGFloat = contentView.frame.size.height - marginY
        containerIconView.frame = CGRect(x: marginX, y: marginTop, width: size, height: size)
        
        let imageSize: CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize) / 2,
                                     y: (size - imageSize) / 2,
                                     width: imageSize,
                                     height: imageSize)
        
        switchView.sizeToFit()
        switchView.frame = CGRect(x: contentView.frame.size.width - switchView.frame.size.width - marginX,
                                  y: (contentView.frame.size.height - switchView.frame.size.height) / 2,
                                  width: switchView.frame.size.width,
                                  height: switchView.frame.size.height)
        
        titleLabel.frame = CGRect(x: 24 + containerIconView.frame.size.width,
                                  y: 0,
                                  width: contentView.frame.size.width - marginX - containerIconView.frame.size.width - marginX,
                                  height: contentView.frame.size.height)
    }
    
    private func configure() {
        contentView.addSubview(containerIconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchView)
        containerIconView.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        switchView.addTarget(self, action: #selector(onDidTapSwitch), for: .valueChanged)
    }
    
    func setup(with model: SettingsSwitchOption) {
        if let icon = model.icon, let iconBackgroundColor = model.iconBackgroundColor {
            containerIconView.backgroundColor = iconBackgroundColor
            iconImageView.image = icon
        }
        
        titleLabel.text = model.title
        switchView.isOn = model.isActive
        switchHandler = model.handler
    }
    
    @objc func onDidTapSwitch() {
        switchHandler?()
    }
}
