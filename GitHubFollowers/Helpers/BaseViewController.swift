//
//  BaseViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation
import UIKit

class BaseViewController<View>: UIViewController where View: ViewCode {
    var customView: View = .init()
    
    override func loadView() {
        view = customView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
