//
//  APIAuthServiceType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol APIAuthServiceType: class {
    func authorizeWith(_ username: String, andPassword password: String, completion: @escaping (Bool) -> Void)
}
