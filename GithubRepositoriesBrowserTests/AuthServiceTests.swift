//
//  AuthServiceTests.swift
//  GithubRepositoriesBrowserTests
//
//  Created by Denis Rumiantsev on 12/20/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import XCTest
@testable import GithubRepositoriesBrowser

class AuthServiceTests: XCTestCase {
    
    var sut: AuthServiceType!
    
    func testSuccessLogin() {
        setupSUTWithAuthCompletionStub(true)
        
        sut.auth(username: NSUUID().uuidString, withPassword: NSUUID().uuidString) { success in
            XCTAssertTrue(success)
        }
    }
    
    func testFailedLogin() {
        setupSUTWithAuthCompletionStub(false)
        sut.auth(username: NSUUID().uuidString, withPassword: NSUUID().uuidString) { success in
            XCTAssertFalse(success)
        }
    }
    
    // MARK: - Tech
    private func setupSUTWithAuthCompletionStub(_ value: Bool) {
        let api = MockAuthAPI()
        api.authCompletionStub = value
        sut = AuthServiceImpl(api: api)
    }
    
    // MARK: - Mocks
    class MockAuthAPI: APIAuthServiceType {
        var authCompletionStub: Bool!
        func authorizeWith(_ username: String, andPassword password: String, completion: @escaping (Bool) -> Void) {
            completion(authCompletionStub)
        }
    }
    
}
