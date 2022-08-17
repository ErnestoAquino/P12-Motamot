//
//  CoreDataStack.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 10/08/2022.
//

import Foundation
import CoreData
import Mixpanel

/**
 * CoreDataStack
 *
 * This class provides the context for the database.
 */
final class CoreDataStack {
    static let shared = CoreDataStack()
    private let persistentContainerName = "Motamot"
    private let persistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    private init () {
        persistentContainer = NSPersistentContainer(name: persistentContainerName)
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                Mixpanel.mainInstance().track(event: "Error loading container")
                fatalError("Unresolved error \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        viewContext = persistentContainer.viewContext
    }
}
