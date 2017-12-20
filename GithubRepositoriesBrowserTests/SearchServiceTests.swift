//
//  SearchServiceTests.swift
//  GithubRepositoriesBrowserTests
//
//  Created by Denis Rumiantsev on 12/20/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import XCTest
import CoreData
@testable import GithubRepositoriesBrowser

class SearchServiceTests: XCTestCase {
    
    var sut: SearchServiceType!
    
    override func setUp() {
        super.setUp()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GithubRepository")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // actually, we have to mock this, but not today :]
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func testObtainingRepositories() {
        let searchMock = MockSearchResolver()
        searchMock.searchStubResult = randomRepositories()
        let mockDb = MockDbService()
        sut = SearchServiceImpl(search: searchMock, dbService: mockDb)
        sut.obtainRepositoriesWith(name: NSUUID().uuidString, onPage: 1, itemsPerPage: 3) { repositories in
            XCTAssertEqual(searchMock.searchStubResult, repositories)
            XCTAssertEqual(mockDb.obtainAll().count, repositories.count)
        }
    }
    
    func testObtainingAllRecentSearchRepositories() {
        var totalRepositoriesArray = [GithubRepositoryPlain]()
        for _ in 0 ... arc4random_uniform(100) {
            totalRepositoriesArray.append(contentsOf: randomRepositories())
        }
        let searchMock = MockSearchResolver()
        let mockDb = MockDbService()
        mockDb.save(totalRepositoriesArray)
        sut = SearchServiceImpl(search: searchMock, dbService: mockDb)
        let result = sut.obtainAllRecentSearchRepositories()
        XCTAssertEqual(result.count, totalRepositoriesArray.count)
    }

    // MARK: - Tech
    private func randomRepositories() -> [GithubRepositoryPlain] {
        let json = try! JSONSerialization.jsonObject(with: ResponseExamples.repositoriesSearchRequestResult.data(using: .utf8)!, options: .allowFragments) as! [String: Any]
        return GithubRepositoryParserImpl().parse(json)
    }
    
    // MARK - Mocks
    
    class MockSearchResolver: RepositoriesOperationsSearchResolverType {
        
        var searchStubResult: [GithubRepositoryPlain]!
        func search(text: String, page: Int, totalItemsCount: Int, sortType: RepositorySearchType, completion: @escaping ([GithubRepositoryPlain]) -> Void) {
            completion(searchStubResult)
        }
        
        func cancelCurrentSearch() { }
    }
    
    class MockDbService: GithubRepositoryDbServiceType {
        private var savedRepositories = [GithubRepositoryPlain]()
        
        var obtainAllStubResult: [GithubRepository]!
        func obtainAll() -> [GithubRepository] {
            return savedRepositories.map { GithubRepository(plainModel: $0, context: (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext) }
        }
        
        var obtainRepositoryWithStubResult: GithubRepository?
        func obtainRepositoryWith(_ uuid: Int32) -> GithubRepository? {
            return obtainRepositoryWithStubResult
        }
        
        func save(_ repositories: [GithubRepositoryPlain]) {
            savedRepositories.append(contentsOf: repositories)
        }
        
        func delete(_ repository: GithubRepositoryPlain) { }
        func markAsViewed(repository: GithubRepositoryPlain) { }
    }
}
