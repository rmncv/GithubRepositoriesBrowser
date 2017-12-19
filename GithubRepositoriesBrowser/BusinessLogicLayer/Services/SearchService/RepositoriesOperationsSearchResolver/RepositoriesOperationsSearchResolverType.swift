//
//  RepositoriesOperationsSearchResolverType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol RepositoriesOperationsSearchResolverType: class {
    func search(text: String, page: Int, totalItemsCount: Int, sortType: RepositorySearchType, completion: @escaping ([GithubRepositoryPlain]) -> Void)
    func cancelCurrentSearch()
}
