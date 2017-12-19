//
//  SearchServiceImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class SearchServiceImpl: SearchServiceType {
    
    private let search: RepositoriesOperationsSearchResolverType
    init(search: RepositoriesOperationsSearchResolverType = RepositoriesOperationsSearchResolverImpl()) {
        self.search = search
    }
    
    func obtainRepositoriesWith(name: String, onPage: Int, itemsPerPage: Int, completion: @escaping ([GithubRepositoryPlain]) -> Void) {
        search.search(text: name, page: onPage, totalItemsCount: itemsPerPage, sortType: .stars) { repositories in
            debugPrint(repositories.count)
        }
    }
}
