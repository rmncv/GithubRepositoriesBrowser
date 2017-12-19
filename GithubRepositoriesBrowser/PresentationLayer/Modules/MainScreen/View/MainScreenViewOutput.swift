//
//  MainScreenMainScreenViewOutput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

protocol MainScreenViewOutput {

    /**
        @author Denis Rumiantsev
        Notify presenter that view is ready
    */

    func viewIsReady()
    func viewWillAppear()
    func didPressedLoginButton()
    func didPressedSearchRepositoriesButtonWhen(textFieldTextIs text: String?)
    func didPressedShowRecentButton()
}
