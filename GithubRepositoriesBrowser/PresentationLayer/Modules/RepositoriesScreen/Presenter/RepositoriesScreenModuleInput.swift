//
//  RepositoriesScreenRepositoriesScreenModuleInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

protocol RepositoriesScreenModuleInput: class {
    func setup(_ state: RepositoriesScreenConfigurator.State)
}
