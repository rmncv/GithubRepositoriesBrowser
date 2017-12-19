//
//  GithubRepositoryParserImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class GithubRepositoryParserImpl: GithubRepositoryParserType {
    func parse(_ data: [String: Any]) -> [GithubRepositoryPlain] {
        guard let items = data["items"] as? [[String: Any]] else {
            return []
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
            let parsedItems = try JSONDecoder().decode([GithubRepositoryPlain].self, from: data)
            return parsedItems
        } catch {
            return []
        }
    }
}
