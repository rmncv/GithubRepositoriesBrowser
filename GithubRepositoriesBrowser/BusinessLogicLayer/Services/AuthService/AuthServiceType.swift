//
//  AuthServiceType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol AuthServiceType: class {
    func auth(username: String, withPassword password: String, completion: @escaping (Bool) -> Void)
}
