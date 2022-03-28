//
//  RepositoriesViewModelTests.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 22/03/22.
//

import XCTest
@testable import GitHubFollowers

class RepositoriesViewModelTests: XCTestCase {
    var requester: RequesterProtocol!
    var sut: RepositoriesViewModelProtocol!
    var dummy = [Repository.dummy()]
    
    override func setUp() {
        requester = RequesterStub(success: dummy)
        sut = RepositoriesViewModel(username: "joaovitorleffa", requester: requester)
    }
    
    func test_fetchRepositories_onInitWithSuccess() {
        XCTAssertEqual(sut.username, "joaovitorleffa")
        XCTAssertFalse(sut.isError.value)
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertEqual(sut.repositories.value, dummy)
    }
    
    func test_fetchRepositories_onInitWithError() {
        requester = RequesterStub(error: .invalidData)
        sut = RepositoriesViewModel(username: "joaovitorleffa", requester: requester)
        
        XCTAssertEqual(sut.username, "joaovitorleffa")
        XCTAssertEqual(sut.repositories.value, [])
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertTrue(sut.isError.value)
    }

    func test_fetchRepositories_loadedAll() {
        requester = RequesterStub(success: [Repository]())
        sut = RepositoriesViewModel(username: "joaovitorleffa", requester: requester)
        
        XCTAssertTrue(sut.repositories.value.isEmpty)
        XCTAssertTrue(sut.loadedAll.value)
    }
    
    func test_fetchRepositories_shouldNotCallTheApi() {
        requester = RequesterStub(success: [Repository]())
        sut = RepositoriesViewModel(username: "joaovitorleffa", requester: requester)
        
        sut.fetchRepositories()
        
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertTrue(sut.loadedAll.value)
        XCTAssertTrue(sut.repositories.value.isEmpty)
    }
}
