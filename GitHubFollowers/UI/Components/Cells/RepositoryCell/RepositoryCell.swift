//
//  RepositoryView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit
import SnapKit

class RepositoryCell: UITableViewCell, Identifier {
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0
        view.backgroundColor = colors.textField()
        return view
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = colors.title()
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let starsHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    let starsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = colors.title()
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let starsImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(systemName: "star.fill")
        img.tintColor = colors.star()
        return img
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = colors.title()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 3
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = colors.background()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: RepositoryCellViewModelProtocol) {
        nameLabel.text = viewModel.name
        starsLabel.text = "\(viewModel.stars)"
        descriptionLabel.text = viewModel.description
    }
}

extension RepositoryCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(vStack)
        vStack.addArrangedSubview(hStack)
        
        hStack.addArrangedSubview(nameLabel)
        hStack.addArrangedSubview(starsHStack)
        starsHStack.addArrangedSubview(starsLabel)
        starsHStack.addArrangedSubview(starsImageView)
        
        vStack.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(110)
        }
        vStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(8)
            make.centerX.centerY.equalToSuperview()
        }
        starsImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }
}
