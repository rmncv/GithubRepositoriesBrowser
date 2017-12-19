//
//  AuthScreenAuthScreenInteractor.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class AuthScreenInteractor: AuthScreenInteractorInput {
    private let service: AuthServiceType
    weak var output: AuthScreenInteractorOutput!
    
    init(service: AuthServiceType = AuthServiceImpl()) {
        self.service = service
    }
    
    func sendAuthRequestWith(username: String, password: String) {
        service.auth(username: username, withPassword: password) { [weak self] success in
            DispatchQueue.main.async {
                success ? self?.output.didSuccessfullyLogin() : self?.output.didFailLogin()
            }
        }
    }
}
