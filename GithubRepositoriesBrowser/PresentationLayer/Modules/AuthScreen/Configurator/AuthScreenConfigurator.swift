//
//  AuthScreenAuthScreenConfigurator.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class AuthScreenConfigurator {
    func view() -> AuthScreenViewController {
        guard let viewController = UIStoryboard(name: String(describing: AuthScreenViewController.self), bundle: nil).instantiateInitialViewController() as? AuthScreenViewController else {
            preconditionFailure()
        }

        let router = AuthScreenRouter()
        
        let presenter = AuthScreenPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = AuthScreenInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
        return viewController
    }
}
