//
//  CoreDataManager.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 30/12/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager() // Singleton instance
    
    // Persistent Container
    let persistentContainer: NSPersistentContainer
    
    // Managed Object Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        // Initialize the persistent container
        persistentContainer = NSPersistentContainer(name: "SellerAppDataModel") // Replace with your .xcdatamodeld file name
        
        // Load persistent stores
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
