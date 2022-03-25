//
//  GFDetails.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit
import SnapKit

class GFDetails: UIStackView {
    let company = GFCardDetail()
    let location = GFCardDetail()
    let email = GFCardDetail()
    let blog = GFCardDetail()
    let twitter = GFCardDetail()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(company: String?, location: String?, email: String?, blog: String?, twitter: String?) {
        self.init(frame: .zero)
        setup(company: company, location: location, email: email, blog: blog, twitter: twitter)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        
        addArrangedSubview(company)
        addArrangedSubview(location)
        addArrangedSubview(email)
        addArrangedSubview(blog)
        addArrangedSubview(twitter)
        
        company.isHidden = true
        location.isHidden = true
        email.isHidden = true
        blog.isHidden = true
        twitter.isHidden = true
    }
    
    private func setupConstraint(of target: GFCardDetail) {
        target.snp.makeConstraints { $0.height.equalTo(32) }
    }
    
    func setup(company: String?, location: String?, email: String?, blog: String?, twitter: String?) {
        if let company = company, !company.isEmpty {
            self.company.isHidden = false
            self.company.setup(label: company, image: SystemImage.building2)
            setupConstraint(of: self.company)
        }
        
        if let location = location, !location.isEmpty {
            self.location.isHidden = false
            self.location.setup(label: location, image: SystemImage.location)
            setupConstraint(of: self.location)
        }
        
        if let email = email, !email.isEmpty {
            self.email.isHidden = false
            self.email.setup(label: email, image: SystemImage.envelope)
            setupConstraint(of: self.email)
        }
        
        if let blog = blog, !blog.isEmpty {
            self.blog.isHidden = false
            self.blog.setup(label: blog, image: SystemImage.link)
            setupConstraint(of: self.blog)
        }
        
        if let twitter = twitter, !twitter.isEmpty {
            self.twitter.isHidden = false
            self.twitter.setup(label: twitter, image: Images.twitterLogo())
            setupConstraint(of: self.twitter)
        }
    }
}
