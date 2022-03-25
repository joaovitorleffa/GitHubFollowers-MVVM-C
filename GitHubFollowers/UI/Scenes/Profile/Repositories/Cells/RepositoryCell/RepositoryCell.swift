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
        view.backgroundColor = Colors.textField()
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
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Colors.title()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let starsHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let starsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = SystemImage.starFill
        imageView.tintColor = Colors.star()
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.numberOfLines = 3
        return label
    }()
    
    let footerHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    let langHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    let langColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.langColorViewSize / 2
        return view
    }()
    
    let langLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.numberOfLines = 1
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = Colors.background()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        starsLabel.text = nil
        descriptionLabel.text = nil
        langLabel.text = nil
        dateLabel.text = nil
        langColorView.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: RepositoryCellViewModelProtocol) {
        nameLabel.text = viewModel.name
        starsLabel.text = "\(viewModel.stars)"
        descriptionLabel.text = viewModel.description
        langLabel.text = viewModel.language
        dateLabel.text = viewModel.date
        langColorView.backgroundColor = viewModel.langColor
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
        vStack.addArrangedSubview(footerHStack)
        
        footerHStack.addArrangedSubview(langHStack)
        footerHStack.addArrangedSubview(dateLabel)
        
        langHStack.addArrangedSubview(langColorView)
        langHStack.addArrangedSubview(langLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(140)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(16)
            make.centerX.centerY.equalToSuperview()
        }
        starsImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        langColorView.snp.makeConstraints { make in
            make.size.equalTo(15)
        }
    }
}

extension RepositoryCell {
    struct Constants {
        static let langColorViewSize: CGFloat = 15
    }
}
