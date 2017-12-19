//
//  MainScreenMainScreenViewInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

protocol MainScreenViewInput: class {

    /**
        @author Denis Rumiantsev
        Setup initial state of the view
    */

    func setupInitialState()
    func setupElementsVisibilityWhen(userIsLoggedIn: Bool)
}
