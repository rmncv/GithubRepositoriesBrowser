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
    private let dbService: GithubRepositoryDbServiceType
    
    init(search: RepositoriesOperationsSearchResolverType = RepositoriesOperationsSearchResolverImpl(),
         dbService: GithubRepositoryDbServiceType = GithubRepositoryDbServiceImpl()) {
        self.search = search
        self.dbService = dbService
    }
    
    func obtainRepositoriesWith(name: String, onPage: Int, itemsPerPage: Int, completion: @escaping ([GithubRepositoryPlain]) -> Void) {
        search.search(text: name, page: onPage, totalItemsCount: itemsPerPage, sortType: .stars) { [weak self] repositories in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.dbService.save(repositories)
            completion(repositories)
        }
    }
    
    func obtainAllRecentSearchRepositories() -> [GithubRepositoryPlain] {
        return dbService.obtainAll().map(GithubRepositoryPlain.init)
    }
    
    func cancelSearch() {
        search.cancelCurrentSearch()
    }
    
    func markAsViewed(_ repository: GithubRepositoryPlain) {
        dbService.markAsViewed(repository: repository)
    }
    
    func delete(_ repository: GithubRepositoryPlain) {
        dbService.delete(repository)
    }
}
