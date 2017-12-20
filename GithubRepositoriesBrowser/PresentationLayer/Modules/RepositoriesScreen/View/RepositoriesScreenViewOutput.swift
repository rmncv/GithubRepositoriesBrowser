//
//  RepositoriesScreenRepositoriesScreenViewOutput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

protocol RepositoriesScreenViewOutput {

    /**
        @author Denis Rumiantsev
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didPressedCancelSearch()
    func didRequestNextRepositoriesPage()
    func didSelected(_ repository: GithubRepositoryPlain)
}
