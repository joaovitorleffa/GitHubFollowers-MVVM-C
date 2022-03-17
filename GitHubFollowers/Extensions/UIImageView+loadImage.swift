//
//  UIImage+loadImage.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Nuke
import UIKit

extension UIImageView {
    func loadImage(from path: String) {
        guard let url = URL(string: path) else { return }
        
        Nuke.loadImage(with: url,
                       options: ImageLoadingOptions(placeholder: images.githubLogo(),
                                                    failureImage: images.githubLogo()),
                       into: self)
    }
}
