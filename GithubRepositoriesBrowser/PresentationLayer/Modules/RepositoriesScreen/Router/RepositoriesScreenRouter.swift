//
//  RepositoriesScreenRepositoriesScreenRouter.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class RepositoriesScreenRouter: RepositoriesScreenRouterInput {
	weak var view: UIViewController?
    
    func showDetailsScreenFor(_ repository: GithubRepositoryPlain) {
        guard let url = URL(string: repository.url) else {
            return
        }
        let vc = URLBrowsingScreen(url: url)
//        let nav = UINavigationController(rootViewController: vc)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        view?.present(vc, animated: true, completion: nil)
    }
}
