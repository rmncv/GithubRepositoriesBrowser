//
//  GithubAPIEndpoint.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

private let kBaseURL = "https://api.github.com"

enum GithubAPIEndpoint {
    
    case authorize(user: String, password: String)
    case repositories(q: String, sort: String, page: Int, perPage: Int)
    
    var requestURL: URL {
        switch self {
            
        case .authorize(_, _):
            return URL(string: kBaseURL + "/authorizations")!
        case .repositories(let q, let sort, let page, let perPage):
            return URL(string: kBaseURL + "/search/repositories?q=\(q)&sort=\(sort)&page=\(page)&per_page=\(perPage)")!
        }
    }
    
    var headers: [String: String] {
        switch self {
            
        case .authorize(let user, let password):
            let encodedAuthData = Data("\(user):\(password)".utf8).base64EncodedString()
            return ["Authorization": "Basic \(encodedAuthData)"]
        case .repositories(_, _, _, _):
            return [:]
        }
    }
}
