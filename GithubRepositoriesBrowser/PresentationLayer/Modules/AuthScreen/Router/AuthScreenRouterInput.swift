//
//  AuthScreenAuthScreenRouterInput.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 19/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

protocol AuthScreenRouterInput {
    weak var view: UIViewController? { get }
    func dismissView()
}
