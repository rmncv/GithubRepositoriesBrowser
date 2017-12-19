//
//  AuthScreenAuthScreenPresenter.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

class AuthScreenPresenter: AuthScreenModuleInput, AuthScreenViewOutput, AuthScreenInteractorOutput {

    weak var view: AuthScreenViewInput!
    var interactor: AuthScreenInteractorInput!
    var router: AuthScreenRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didPressedLoginButtonWith(usernameTextFieldText: String?, passwordTextFieldText: String?) {
        guard let username = usernameTextFieldText,
            let password = passwordTextFieldText else {
                return
        }
        view.beginIgnoringUserInteractionAndShowActivityIndicator()
        interactor.sendAuthRequestWith(username: username, password: password)
    }
    
    func didSuccessfullyLogin() {
        view.endIgnoringUserInteractionAndShowActivityIndicator()
        router.dismissView()
    }
    
    func didFailLogin() {
        view.endIgnoringUserInteractionAndShowActivityIndicator()
        view.showFailedLoginAlert()
    }
}
