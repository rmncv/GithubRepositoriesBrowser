//
//  GithubRepositoryParserType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol GithubRepositoryParserType: class {
    func parse(_ data: [String: Any]) -> [GithubRepositoryPlain]
}
