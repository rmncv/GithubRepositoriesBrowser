//
//  AuthServiceImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class AuthServiceImpl: AuthServiceType {
    
    private let api: APIAuthServiceType
    init(api: APIAuthServiceType = APIAuthServiceImpl()) {
        self.api = api
    }
    
    func auth(username: String, withPassword password: String, completion: @escaping (Bool) -> Void) {
        // for test purposes, it's enoug bool value
        // in real projects, callback will be an error
        api.authorizeWith(username, andPassword: password) { success in
            UserDefaults.standard.isAuthorized = success
            completion(success)
        }
    }
}
