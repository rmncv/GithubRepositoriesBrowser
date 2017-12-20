//
//  RepositoriesScreenRepositoriesScreenConfigurator.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class RepositoriesScreenConfigurator {
    
    private let state: State
    
    init(state: State) {
        self.state = state
    }
    
    enum State {
        case search(q: String)
        case recent
    }
    
    func view() -> RepositoriesScreenViewController {
        guard let viewController = UIStoryboard(name: String(describing: RepositoriesScreenViewController.self), bundle: nil).instantiateInitialViewController() as? RepositoriesScreenViewController else {
            preconditionFailure()
        }

        let router = RepositoriesScreenRouter()
        router.view = viewController
        
        let presenter = RepositoriesScreenPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.setup(state)
        
        let interactor = RepositoriesScreenInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
        return viewController
    }
}
