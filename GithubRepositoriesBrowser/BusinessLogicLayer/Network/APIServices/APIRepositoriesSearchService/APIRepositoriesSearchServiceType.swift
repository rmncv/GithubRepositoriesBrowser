//
//  APIRepositoriesSearchServiceType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

enum RepositoriesSearchResult {
    case success([String: Any])
    case error(RepositorySearchError)
}

enum RepositorySearchError: Swift.Error {
    case unknown
    case parsingError
    // for test project it's enough ? :]
}

protocol APIRepositoriesSearchServiceType: class {
    @discardableResult
    func searchRepositoriesWith(name: String, onPage page: Int, itemsPerPage: Int, sortType: RepositorySearchType, completion: @escaping (RepositoriesSearchResult) -> Void) -> URLSessionTask
}
