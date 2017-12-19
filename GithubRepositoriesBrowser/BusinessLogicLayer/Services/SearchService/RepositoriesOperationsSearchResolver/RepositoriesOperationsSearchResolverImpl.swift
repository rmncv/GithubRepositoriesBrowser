//
//  RepositoriesOperationsSearchResolverImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation

class RepositoriesOperationsSearchResolverImpl: RepositoriesOperationsSearchResolverType {
    private let api: APIRepositoriesSearchServiceType
    private let parser: GithubRepositoryParserType
    private let concurrentOperationCount: Int
    
    private var result = [GithubRepositoryPlain]()
    private let lock = NSLock()
    private let operationQueue = OperationQueue()
    
    init(api: APIRepositoriesSearchServiceType = APIRepositoriesSearchServiceImpl(), parser: GithubRepositoryParserType = GithubRepositoryParserImpl(), concurrentOperationCount: Int = 2) {
        self.api = api
        self.parser = parser
        self.concurrentOperationCount = concurrentOperationCount
        self.operationQueue.maxConcurrentOperationCount = concurrentOperationCount
    }
    
    func search(text: String, page: Int, totalItemsCount: Int, sortType: RepositorySearchType, completion: @escaping ([GithubRepositoryPlain]) -> Void) {
        cancelCurrentSearch()
        
        let resultOperation = BlockOperation {
            completion(self.result)
        }

        let itemsPerPage = totalItemsCount / concurrentOperationCount
        
        var operations = [Operation]()
        
        for i in 1 ... concurrentOperationCount {
            let searchParameters = GithubRepositorySearchParameters(name: text, page: page + i, itemsPerPage: itemsPerPage, sortType: sortType)
            let operation = GithubRepositorySearchOperation(api: api, parser: parser, requestParameters: searchParameters)
            operation.completionBlock = {
                self.lock.lock()
                self.result += operation.requestResult
                self.lock.unlock()
            }
            resultOperation.addDependency(operation)
            operations.append(operation)
        }
        
        operations.append(resultOperation)
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    func cancelCurrentSearch() {
        result.removeAll()
        operationQueue.cancelAllOperations()
    }
}
