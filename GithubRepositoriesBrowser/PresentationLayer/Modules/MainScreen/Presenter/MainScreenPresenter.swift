//
//  MainScreenMainScreenPresenter.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class MainScreenPresenter: MainScreenModuleInput, MainScreenViewOutput, MainScreenInteractorOutput {

    weak var view: MainScreenViewInput!
    var interactor: MainScreenInteractorInput!
    var router: MainScreenRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func viewWillAppear() {
        view.setupElementsVisibilityWhen(userIsLoggedIn: UserDefaults.standard.isAuthorized)
    }
    
    func didPressedLoginButton() {
        router.showAuthScreen()
    }
    
    func didPressedSearchRepositoriesButtonWhen(textFieldTextIs text: String?) {
        guard let text = text, !text.isEmpty else {
            return
        }
        
        router.showRepositoriesScreen(withSearchText: text)
    }
    
    func didPressedShowRecentButton() {
        router.showRecentSearchResultsScreen()
    }
}
