//
//  GithubRepositorySearchParameters.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

struct GithubRepositorySearchParameters {
    let name: String
    let page: Int
    let itemsPerPage: Int
    let sortType: RepositorySearchType
}
