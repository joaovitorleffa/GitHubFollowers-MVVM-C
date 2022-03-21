//
//  RepositoryView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit
import SnapKit

class RepositoryCell: UITableViewCell, Identifier {
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
        stack.distribution = .equalSpacing
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
        img.image = UIImage(named: "stars.fill")
        img.tintColor = colors.textField() // TODO: colors.stars()
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
        addSubview(hStack)
        hStack.addArrangedSubview(nameLabel)
        hStack.addArrangedSubview(starsHStack)
        starsHStack.addArrangedSubview(starsLabel)
        starsHStack.addArrangedSubview(starsImageView)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().offset(16)
        }
        starsImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
