//
//  GithubRepositoryParserTests.swift
//  GithubRepositoriesBrowserTests
//
//  Created by Denis Rumiantsev on 12/20/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import XCTest
@testable import GithubRepositoriesBrowser

class GithubRepositoryParserTests: XCTestCase {
    
    var sut: GithubRepositoryParserType!
    
    override func setUp() {
        super.setUp()
        sut = GithubRepositoryParserImpl()
    }
    
    func testGithubRepositoriesJSONParsing() {
        // given
        let data = ResponseExamples.repositoriesSearchRequestResult.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        
        // when
        let result = sut.parse(json)
        
        // then
        XCTAssertFalse(result.isEmpty)
        for repository in result {
            XCTAssertFalse(repository.name.isEmpty)
            XCTAssertNotNil(repository.repositoryDescription)
            XCTAssertFalse(repository.url.isEmpty)
        }
        XCTAssertTrue(result.count == 3)
    }
    
}
