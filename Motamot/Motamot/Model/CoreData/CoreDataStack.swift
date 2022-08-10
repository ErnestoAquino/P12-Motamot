//
//  CoreDataStack.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 10/08/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    private let persistentContainerName = "Motamot"
    private let persistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    private init () {
        persistentContainer = NSPersistentContainer(name: persistentContainerName)
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        viewContext = persistentContainer.viewContext
    }
}
