//
//  MainScreenMainScreenViewController.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, MainScreenViewInput {

    var output: MainScreenViewOutput!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var searchElementsContainer: UIView!
    @IBOutlet weak var searchTextField: UITextField!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }

    // MARK: MainScreenViewInput
    func setupInitialState() {
    	navigationItem.title = "Github"
    }
    
    func setupElementsVisibilityWhen(userIsLoggedIn: Bool) {
        loginButton.isHidden = userIsLoggedIn
        searchElementsContainer.isHidden = !userIsLoggedIn
    }
    
    // MARK: - Actions
    @IBAction func didPressedLoginButton(_ sender: UIButton) {
        output.didPressedLoginButton()
    }
    
    @IBAction func didPressedSearchButton(_ sender: UIButton) {
        output.didPressedSearchRepositoriesButtonWhen(textFieldTextIs: searchTextField.text)
    }
    
    @IBAction func didPressedShowRecentButton(_ sender: UIButton) {
        output.didPressedShowRecentButton()
    }
}
