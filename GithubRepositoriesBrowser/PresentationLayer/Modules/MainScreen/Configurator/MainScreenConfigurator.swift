//
//  MainScreenMainScreenConfigurator.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class MainScreenConfigurator {
    func view() -> MainScreenViewController {
        guard let viewController = UIStoryboard(name: String(describing: MainScreenViewController.self), bundle: nil).instantiateInitialViewController() as? MainScreenViewController else {
            preconditionFailure()
        }

        let router = MainScreenRouter()
        router.view = viewController
        
        let presenter = MainScreenPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = MainScreenInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
        return viewController
    }
}
