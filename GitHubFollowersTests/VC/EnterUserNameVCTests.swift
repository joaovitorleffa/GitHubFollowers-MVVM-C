//
//  EnterUserNameVCTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 28/03/22.
//

import XCTest
@testable import GitHubFollowers

class EnterUserNameVCTests: XCTestCase {
    var sut: EnterUsernameViewController!
    var viewModel: EnterUsernameViewModelSpy!
    
    override func setUp() {
        sut = EnterUsernameViewController()
        viewModel = EnterUsernameViewModelSpy()
        sut.viewModel = viewModel
    }
    
    func test_findFollowers() {
        sut.customView.textField.text = "joaovitorleffa"
        
        sut.findFollowers()
    
        XCTAssertEqual(viewModel.findFollowersCalledWith, "joaovitorleffa")
    }
}
