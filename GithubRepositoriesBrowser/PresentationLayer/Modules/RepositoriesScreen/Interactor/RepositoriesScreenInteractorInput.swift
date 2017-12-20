//
//  RepositoriesScreenRepositoriesScreenInteractorInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol RepositoriesScreenInteractorInput {
    var service: SearchServiceType { get }
    
    func obtainRepositoriesWithName(startedWith name: String, onPage page: Int, itemsPerPage: Int)
    func obtainAllPreviouslyStoredRepositories()
    func cancelSearch()
    func delete(_ repository: GithubRepositoryPlain)
    func markAsViewed(_ repository: GithubRepositoryPlain)
}
