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

    }
}
