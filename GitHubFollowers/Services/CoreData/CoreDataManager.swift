//
//  CoreDataManager.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "GitHubFollowers")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("[CoreDataManager()] Load store error")
            }
        }
        
        mainContext = persistentContainer.viewContext
    }
}
