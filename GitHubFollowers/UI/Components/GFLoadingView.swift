//
//  GFLoadingView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import UIKit
import SnapKit

class GFLoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.startAnimating()
        return indicator
    }()
    
    private func configure() {
        backgroundColor = colors.background()?.withAlphaComponent(0.55)
        
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
