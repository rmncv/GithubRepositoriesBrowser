//
//  String+Extension.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation
extension String {
    
    func truncate(by length: Int = 30, ending: String = "...") -> String {
        return count > length ? String(prefix(length)) + ending : self
    }
}
