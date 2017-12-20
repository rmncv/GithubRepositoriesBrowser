//
//  GithubRepositoryPlain.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

struct GithubRepositoryPlain: Decodable {
    let uuid: Int
    let name: String
    let repositoryDescription: String?
    let stars: Int
    let url: String
    private(set) var isViewed: Bool
    
    enum CodingKeys: String, CodingKey {
        case uuid = "id"
        case repositoryDescription = "description"
        case name = "full_name"
        case url = "html_url"
        case stars = "stargazers_count"
    }
}

// MARK: - Mutating funcs
extension GithubRepositoryPlain {
    mutating func markAsViewed() {
        self.isViewed = true
    }
}

// MARK: - Init
extension GithubRepositoryPlain {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(Int.self, forKey: .uuid)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
        stars = try container.decode(Int.self, forKey: .stars)
        repositoryDescription = try container.decode(String?.self, forKey: .repositoryDescription)?.truncate()
        isViewed = false
    }
    
    init(managedObject: GithubRepository) {
        uuid = Int(managedObject.uuid)
        name = managedObject.name
        repositoryDescription = managedObject.repositoryDescription
        stars = Int(managedObject.stars)
        url = managedObject.url
        isViewed = managedObject.isViewed
    }
}

extension GithubRepositoryPlain: Equatable {
    static func == (lhs: GithubRepositoryPlain, rhs: GithubRepositoryPlain) -> Bool {
        return lhs.uuid == rhs.uuid &&
        lhs.name == rhs.name &&
        lhs.repositoryDescription == rhs.repositoryDescription &&
        lhs.stars == rhs.stars &&
        lhs.url == rhs.url &&
        lhs.isViewed == rhs.isViewed
    }
}
