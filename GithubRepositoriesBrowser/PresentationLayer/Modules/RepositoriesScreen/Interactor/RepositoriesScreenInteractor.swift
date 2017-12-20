//
//  RepositoriesScreenRepositoriesScreenInteractor.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class RepositoriesScreenInteractor: RepositoriesScreenInteractorInput {
    
    weak var output: RepositoriesScreenInteractorOutput!
    var service: SearchServiceType
    
    init(service: SearchServiceType = SearchServiceImpl()) {
        self.service = service
    }

    func obtainRepositoriesWithName(startedWith name: String, onPage page: Int, itemsPerPage: Int) {
        service.obtainRepositoriesWith(name: name, onPage: page, itemsPerPage: itemsPerPage) { [weak self] repositories in
            DispatchQueue.main.async {
                self?.output.didObtain(repositories)
            }
        }
    }
    
    func obtainAllPreviouslyStoredRepositories() {
        let repositories = service.obtainAllRecentSearchRepositories()
        output.didObtain(repositories)
    }
    
    func cancelSearch() {
        service.cancelSearch()
    }
    
    func markAsViewed(_ repository: GithubRepositoryPlain) {
        service.markAsViewed(repository)
    }
}
