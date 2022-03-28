//
//  RepositoryCellViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 28/03/22.
//

import XCTest
@testable import GitHubFollowers

class RepositoryCellViewModelTests: XCTestCase {

    var sut: RepositoryCellViewModelProtocol!
    var dummy = Repository.dummy()
    var dummyEmptyLang = Repository.dummyEmptyLanguage()

    override func setUp() {
        sut = RepositoryCellViewModel(repository: dummy)
    }
    
    func test_props() {
        XCTAssertEqual(sut.name, dummy.name)
        XCTAssertEqual(sut.description, dummy.repositoryDescription)
        XCTAssertEqual(sut.stars, dummy.stargazersCount)
        XCTAssertEqual(sut.language, dummy.language)
        XCTAssertEqual(sut.date, "10/08/2019")
        XCTAssertEqual(sut.langColor, Language.colors["Java"])
    }
    
    func test_props_lanColorNil() {
        sut = RepositoryCellViewModel(repository: dummyEmptyLang)
        
        XCTAssertEqual(sut.name, dummyEmptyLang.name)
        XCTAssertEqual(sut.description, dummyEmptyLang.repositoryDescription)
        XCTAssertEqual(sut.stars, dummyEmptyLang.stargazersCount)
        XCTAssertEqual(sut.language, dummyEmptyLang.language)
        XCTAssertEqual(sut.date, "10/08/2019")
        XCTAssertNil(sut.langColor)
    }
}
