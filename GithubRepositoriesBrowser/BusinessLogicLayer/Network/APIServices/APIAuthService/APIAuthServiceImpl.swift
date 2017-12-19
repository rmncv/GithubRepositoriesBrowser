//
//  APIAuthServiceImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class APIAuthServiceImpl: APIAuthServiceType {
    
    private let network: NetworkService
    init(networkService: NetworkService = .init()) {
        self.network = networkService
    }
    
    func authorizeWith(_ username: String, andPassword password: String, completion: @escaping (Bool) -> Void) {
        let endpoint = GithubAPIEndpoint.authorize(user: username, password: password)
        network.request(url: endpoint.requestURL, headers: endpoint.headers) { result in
            switch result {
            case .success(_): completion(true)
            case .error(_): completion(false)
            }
        }
    }
}
