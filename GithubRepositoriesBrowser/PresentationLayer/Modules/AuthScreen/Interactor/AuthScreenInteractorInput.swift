//
//  AuthScreenAuthScreenInteractorInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol AuthScreenInteractorInput {
    func sendAuthRequestWith(username: String, password: String)
}
