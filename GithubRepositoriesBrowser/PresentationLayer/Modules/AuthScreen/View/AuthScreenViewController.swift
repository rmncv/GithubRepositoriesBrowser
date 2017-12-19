//
//  AuthScreenAuthScreenViewController.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class AuthScreenViewController: UIViewController, AuthScreenViewInput {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var output: AuthScreenViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: AuthScreenViewInput
    func setupInitialState() {
    	navigationItem.title = "Authorization"
        activityIndicator.stopAnimating()
        
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AuthScreenViewController.didPressedDismissButton))
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    func beginIgnoringUserInteractionAndShowActivityIndicator() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.startAnimating()
    }
    
    func endIgnoringUserInteractionAndShowActivityIndicator() {
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicator.stopAnimating()
    }
    
    func showFailedLoginAlert() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong on login. Please, try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func didPressedLoginButton(_ sender: UIButton) {
        output.didPressedLoginButtonWith(usernameTextFieldText: usernameTextField.text, passwordTextFieldText: passwordTextField.text)
    }
    
    @objc private func didPressedDismissButton() {
        dismiss(animated: true, completion: nil)
    }
}
