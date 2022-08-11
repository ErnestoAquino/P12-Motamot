//
//  LocalDictionaryService.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 10/08/2022.
//

import Foundation
import CoreData

/**
 * LocalDictionaryService
 *
 * This class is used to manage local words.
 */

final public class LocalDictionaryService {
    private let mainContext: NSManagedObjectContext
    var favoriteWords: [FavoriteWord] = []

    init (mainContext: NSManagedObjectContext = CoreDataStack.shared.viewContext) {
        self.mainContext = mainContext
    }

    /**
     This method fetches the stored words and saves them in favoriteWords.
     */
    func fetchWords() {
        favoriteWords = []
        let request: NSFetchRequest<FavoriteWord> = FavoriteWord.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "word", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        guard let words = try? mainContext.fetch(request) else { return }
        for word in words {
            favoriteWords.append(word)
        }
    }

    /**
     This method delete a FavoriteWord from database.
     
     - parameter word: Word to be delete.
     */
    func deleteWord(_ word: FavoriteWord?) {
        guard let wordToDelete = word else { return }
        mainContext.delete(wordToDelete)
        do {
            try mainContext.save()
        } catch  {
            print("Sorry we have encountered a problem deleting word")
        }
    }

    /**
     This method delete a FavoriteWord from database.
     
     - parameter word: String of the word to be delete.
     */
    func deleteWord(_ word: String) {
        let fechtRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteWord")
        let predicate = NSPredicate(format: "word == '\(word)'")
        fechtRequest.predicate = predicate
        let result = try? mainContext.fetch(fechtRequest)
        guard let result = result else { return }
        if let resultData = result as? [FavoriteWord] {
            for object in resultData {
                mainContext.delete(object)
            }
            do {
                try mainContext.save()
                print("Word: | \(word) | has been delete.")
            } catch  {
                print("Unresolved error.")
            }
        }
    }

    /**
     This method saves a word in the database.
     
     - parameter wordToSave: Word to be saved.
     */
    func saveWord(_ wordToSave: LocalWord?) {
        guard let wordToSave = wordToSave else { return }
        let word = FavoriteWord(context: mainContext)
        word.word =  wordToSave.word
        word.audio = wordToSave.audio
        word.urlAudio = wordToSave.urlAudio
        word.definition = wordToSave.definition
        word.phonetic = wordToSave.phonetic
        word.origin = wordToSave.origin
        word.antonyms = wordToSave.antonyms
        word.synonyms = wordToSave.synonyms
        word.examples = wordToSave.examples

        do {
            try mainContext.save()
            print("Word: | \(wordToSave.word) | has been saved")
        } catch  {
            print("Sorry, we have encountered an error saving the word.")
        }
    }

    /**
     This method checks if a word is already stored in the database.
     
     - parameter word: String with the word to be checked.
     
     - returns: If there is already an objec stored in the database it returns true, otherwise it returns false.
     */
    func controlWord(_ word: String?) -> Bool {
        guard let word = word  else {
            return false
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteWord")
        let predicate = NSPredicate(format: "word == '\(word)'")
        request.predicate = predicate
        let result = try? mainContext.fetch(request)
        guard let dataResult = result as? [FavoriteWord] else {
            return false
        }
        for _ in dataResult {
            return true
        }
        return false
    }
}
