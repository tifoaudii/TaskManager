//
//  CoreDataStack.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//

import CoreData

final class CoreDataStack {
    
    private let storeContainer: NSPersistentContainer
    
    init(inMemory: Bool) {
        storeContainer = NSPersistentContainer(name: "Task")
        
        if inMemory {
            if let storeDescription = storeContainer.persistentStoreDescriptions.first {
                storeDescription.type = NSInMemoryStoreType
            }
        }
        
        storeContainer.loadPersistentStores { _ , error in
            guard error == nil else {
                return
            }
        }
    }
    
    lazy var viewContext: NSManagedObjectContext = {
        storeContainer.viewContext
    }()
    
    func save() {
        guard viewContext.hasChanges else {
            return
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}
