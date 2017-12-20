//
//  RepositoriesScreenRepositoriesScreenRouterInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

protocol RepositoriesScreenRouterInput {
	weak var view: UIViewController? { get }
    func showDetailsScreenFor(_ repository: GithubRepositoryPlain)
}
