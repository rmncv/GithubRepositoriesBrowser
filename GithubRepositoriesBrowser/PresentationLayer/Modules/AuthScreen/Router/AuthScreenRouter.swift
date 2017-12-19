//
//  AuthScreenAuthScreenRouter.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class AuthScreenRouter: AuthScreenRouterInput {
    weak var view: UIViewController?
    func dismissView() {
        view?.dismiss(animated: true, completion: nil)
    }
}
