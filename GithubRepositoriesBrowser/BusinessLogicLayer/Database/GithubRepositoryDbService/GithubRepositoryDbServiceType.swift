//
//  GithubRepositoryDbServiceType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol GithubRepositoryDbServiceType: class {
    func obtainAll() -> [GithubRepository]
    func obtainRepositoryWith(_ uuid: Int32) -> GithubRepository?
    func save(_ repositories: [GithubRepositoryPlain])
    func delete(_ repository: GithubRepositoryPlain)
    func markAsViewed(repository: GithubRepositoryPlain)
}
