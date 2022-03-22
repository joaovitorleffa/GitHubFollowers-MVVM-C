//
//  GFCardDetail.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit
import SnapKit

class GFCardDetail: UIView {
    let imageView: UIImageView = {
        let img = UIImageView()
        img.tintColor = colors.title()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = colors.title()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        label.snp.makeConstraints { make in
            make.top.bottom.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    func setup(label: String, image: UIImage?) {
        self.label.text = label
        self.imageView.image = image ?? images.githubLogo()
    }
}
