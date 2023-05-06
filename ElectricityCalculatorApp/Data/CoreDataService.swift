//
//  CoreDataService.swift
//  ElectricityCalculatorApp
//
//  Created by Zara on 23/01/2023.
//

import Foundation
import CoreData

protocol CoreDataServiceType {
    func saveContext ()
    func saveWorkingContext(context: NSManagedObjectContext) -> Bool
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
    var workingContext: NSManagedObjectContext { get }
    
}
final class CoreDataService: CoreDataServiceType {
    
    init() {
        _ = self.persistentContainer
    }
    
    var managedObjectContext: NSManagedObjectContext {
        get {
            return self.persistentContainer.viewContext
        }
    }
    
        //childContext on private queue
    var workingContext: NSManagedObjectContext {
        get {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = self.managedObjectContext
            return context
        }
    }
    
    func saveContext () {
            //  guard managedObjectContext.hasChanges else { return }
        self.managedObjectContext.performAndWait {
                // if self.managedObjectContext.hasChanges {
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Error while saving main context: \(error)")
            }
                //}
        }
    }
    
    @discardableResult
    func saveWorkingContext(context: NSManagedObjectContext) -> Bool {
            //guard context.hasChanges else { return false }
        do {
            try context.save()
            saveContext()
        } catch {
            print("Error while saving working context: \(error)")
        }
        return true
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ElectricityCalculatorApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
}
