//
//  FollowersListViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

class FollowersListViewController: BaseViewController<FollowersListView> {
    var viewModel: FollowerListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.lbl.text = viewModel?.username
        // Do any additional setup after loading the view.
    }

}
