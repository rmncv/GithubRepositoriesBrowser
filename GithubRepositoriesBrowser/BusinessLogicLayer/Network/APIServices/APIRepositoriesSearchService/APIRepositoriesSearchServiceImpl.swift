//
//  APIRepositoriesSearchServiceImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

enum RepositorySearchType: String {
    case stars = "stars"
}

class APIRepositoriesSearchServiceImpl: APIRepositoriesSearchServiceType {
    private let network: NetworkService
    init(networkService: NetworkService = .init()) {
        self.network = networkService
    }
    
    func searchRepositoriesWith(name: String, onPage page: Int, itemsPerPage: Int, sortType: RepositorySearchType, completion: @escaping (RepositoriesSearchResult) -> Void) {
        let endpoint = GithubAPIEndpoint.repositories(q: name, sort: sortType.rawValue, page: page, perPage: itemsPerPage)
        network.request(url: endpoint.requestURL) { result in
            switch result {
                
            case .success(let data):
                do {
                    let root = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    guard let castedRoot = root as? [String: Any] else {
                        completion(.error(.parsingError))
                        return
                    }
                    completion(.success(castedRoot))
                } catch {
                    completion(.error(.parsingError))
                }
            case .error(_): completion(.error(.unknown))
            }
        }
    }
}
