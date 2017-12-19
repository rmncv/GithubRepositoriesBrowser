//
//  GithubRepository+CoreDataProperties.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//
//

import Foundation
import CoreData


extension GithubRepository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GithubRepository> {
        return NSFetchRequest<GithubRepository>(entityName: "GithubRepository")
    }

    @NSManaged public var isViewed: Bool
    @NSManaged public var name: String!
    @NSManaged public var repositoryDescription: String?
    @NSManaged public var stars: Int32
    @NSManaged public var url: String!
    @NSManaged public var uuid: Int32

}
