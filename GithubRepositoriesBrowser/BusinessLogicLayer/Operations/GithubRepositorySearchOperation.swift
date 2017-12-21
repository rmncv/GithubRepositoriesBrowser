//
//  GithubRepositorySearchOperation.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class GithubRepositorySearchOperation: GRBOperation {
    
    private let api: APIRepositoriesSearchServiceType
    private let parser: GithubRepositoryParserType
    private let requestParameters: GithubRepositorySearchParameters
    
    private(set) var requestResult = [GithubRepositoryPlain]()
    private var currentRequest: URLSessionTask?
    
    init(api: APIRepositoriesSearchServiceType, parser: GithubRepositoryParserType, requestParameters: GithubRepositorySearchParameters) {
        self.api = api
        self.parser = parser
        self.requestParameters = requestParameters
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        
        executing(true)
        currentRequest = api.searchRepositoriesWith(name: requestParameters.name, onPage: requestParameters.page, itemsPerPage: requestParameters.itemsPerPage, sortType: requestParameters.sortType) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
                
            case .success(let data):
                strongSelf.requestResult = strongSelf.parser.parse(data)
            case .error(_):
                ()
                // we don't need error handling for test purposes, do we?
            }
            strongSelf.executing(false)
            strongSelf.finish(true)
            debugPrint("Did finished \(String(describing: self))")
        }
    }
    
    override func cancel() {
        super.cancel()
        cancelNetworkRequest()
    }
    
    private func cancelNetworkRequest() {
        currentRequest?.cancel()
    }
}
