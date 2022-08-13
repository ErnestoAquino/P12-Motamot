//
//  FakeCoreDataStack.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 12/08/2022.
//

import Foundation
import CoreData

/**
 * FakeCoreDataStack
 *
 *  This class is a fake of CoreDataStack. It provides the context to perform the tests using the in-memory store type.
 */
class FakeCoreDataStack {

    private let persistentContainer: NSPersistentContainer
        let mainContext: NSManagedObjectContext
        private let persistentContinerName = "Motamot"
             
        init() {
            persistentContainer = NSPersistentContainer(name: persistentContinerName)
            let description = persistentContainer.persistentStoreDescriptions.first
            description?.type = NSInMemoryStoreType

            persistentContainer.loadPersistentStores { storeDescription, error in
                guard error == nil else {
                    fatalError("Unresolved error \(String(describing: error?.localizedDescription))")
                }
            }
            mainContext = persistentContainer.viewContext
        }
}
