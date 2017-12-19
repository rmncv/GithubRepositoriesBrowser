//
//  MainScreenMainScreenRouter.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class MainScreenRouter: MainScreenRouterInput {
	weak var view: UIViewController?
    
    func showAuthScreen() {
        let authView = AuthScreenConfigurator().view()
        let nav = UINavigationController(rootViewController: authView)
        view?.present(nav, animated: true, completion: nil)
    }
    
    func showRepositoriesScreen(withSearchText text: String) {
        
    }
    
    func showRecentSearchResultsScreen() {
        
    }
}
