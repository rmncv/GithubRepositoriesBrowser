//
//  GithubRepositoryDbServiceImpl.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import Foundation
import CoreData

class GithubRepositoryDbServiceImpl: GithubRepositoryDbServiceType {
    private lazy var coreDataStack = AppCoreDataStack()
    
    func obtainAll() -> [GithubRepository] {
        let request: NSFetchRequest<GithubRepository> = GithubRepository.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "stars", ascending: false)]
        var result = [GithubRepository]()
        do {
            result = try coreDataStack.persistentContainer.viewContext.fetch(request)
        } catch {
            assertionFailure()
        }
        
        return result
    }
    
    func save(_ repositories: [GithubRepositoryPlain]) {
        coreDataStack.persistentContainer.performBackgroundTask { context in
            context.mergePolicy = NSMergePolicy.overwrite
            _ = repositories.map { GithubRepository(plainModel: $0, context: context) }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func obtainRepositoryWith(_ uuid: Int32) -> GithubRepository? {
        let request: NSFetchRequest<GithubRepository> = GithubRepository.fetchRequest()
        request.predicate = NSPredicate(format: "uuid == %d", uuid)
        var repository: GithubRepository?
        do {
            repository = try coreDataStack.persistentContainer.viewContext.fetch(request).first
        } catch { }
        return repository
        
    }
    
    func markAsViewed(repository: GithubRepositoryPlain) {
        guard let managedRepository = obtainRepositoryWith(Int32(repository.uuid)) else {
            return
        }
        coreDataStack.persistentContainer.performBackgroundTask { context in
            managedRepository.isViewed = true
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
