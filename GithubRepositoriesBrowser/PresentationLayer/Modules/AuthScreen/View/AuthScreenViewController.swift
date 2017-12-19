//
//  AuthScreenAuthScreenViewController.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class AuthScreenViewController: UIViewController, AuthScreenViewInput {

    var output: AuthScreenViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: AuthScreenViewInput
    func setupInitialState() {
    	
    }
}
