//
//  RepositoriesScreenRepositoriesScreenInteractorOutput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol RepositoriesScreenInteractorOutput: class {
    func didObtain(_ repositories: [GithubRepositoryPlain])
}
