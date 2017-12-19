//
//  GithubRepository+CoreDataClass.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//
//

import Foundation
import CoreData

@objc(GithubRepository)
public class GithubRepository: NSManagedObject {
    convenience init(plainModel: GithubRepositoryPlain, context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: "GithubRepository", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.uuid = Int32(plainModel.uuid)
        self.name = plainModel.name
        self.stars = Int32(plainModel.stars)
        self.url = plainModel.url
        self.isViewed = plainModel.isViewed
        self.repositoryDescription = plainModel.repositoryDescription
    }
}
