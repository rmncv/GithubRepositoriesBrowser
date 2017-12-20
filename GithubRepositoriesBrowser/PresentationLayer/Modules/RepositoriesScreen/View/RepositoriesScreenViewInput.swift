//
//  RepositoriesScreenRepositoriesScreenViewInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

protocol RepositoriesScreenViewInput: class {

    /**
        @author Denis Rumiantsev
        Setup initial state of the view
    */
    var itemsPerPage: Int! { get set }
    var currentPage: Int! { get set }
    func setupInitialState(forState state: RepositoriesScreenConfigurator.State)
    func add(_ repositories: [GithubRepositoryPlain])
    func reloadData()
    func makeRightBarButtonItem(enabled: Bool)
    func makeActivityIndicator(hidden: Bool)
    func replace(_ repository: GithubRepositoryPlain, with newRepositry: GithubRepositoryPlain)
    func delete(_ repository: GithubRepositoryPlain)
}
