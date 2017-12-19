//
//  SearchServiceType.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

protocol SearchServiceType: class {
    func obtainRepositoriesWith(name: String, onPage: Int, itemsPerPage: Int, completion: @escaping ([GithubRepositoryPlain]) -> Void)
}
