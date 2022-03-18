//
//  GFErrorView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import UIKit
import SnapKit

class GFErrorView: UIView {
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = colors.title()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setup(title: title)
    }
    
    private func configure() {
        backgroundColor = colors.background()
        addSubview(titleLbl)
    }
    
    func setup(title: String) {
        titleLbl.text = title
        
        titleLbl.snp.makeConstraints { make in
            make.leading.top.centerX.centerY.equalToSuperview()
        }
    }
}
