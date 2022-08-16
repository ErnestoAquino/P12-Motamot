//
//  LocalDictionaryServiceTestCase.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 13/08/2022.
//

import XCTest
import CoreData
@testable import Motamot

class LocalDictionaryServiceTestCase: XCTestCase {

    func testGivenLocalWord_WhenCallSaveWord_ThenWordShouldBeSaved() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        //Given
        let word = LocalWord(word: "Test",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //When
        localDictionaryService.saveWord(word)
        localDictionaryService.fetchWords()
        //Then
        XCTAssertTrue(localDictionaryService.favoriteWords.count == 1)
    }

    func testLocalWordNil_WhenCallSaveWord_ThenListOfFavoritesWordShouldBeEmpty() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        //Given
        let wordNil: LocalWord? = nil
        //When
        localDictionaryService.saveWord(wordNil)
        localDictionaryService.fetchWords()
        //Then
        XCTAssertTrue(localDictionaryService.favoriteWords.isEmpty)
    }

    func testGivenThreeStoredWords_WhenCallFechWords_ThenShouldHaveThreeWords() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordOne = LocalWord(word: "word one",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordTwo = LocalWord(word: "word two",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordThree = LocalWord(word: "word three",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //Given
        localDictionaryService.saveWord(wordOne)
        localDictionaryService.saveWord(wordTwo)
        localDictionaryService.saveWord(wordThree)
        //When
        localDictionaryService.fetchWords()
        //Then
        XCTAssertEqual(localDictionaryService.favoriteWords.count, 3)
    }

    func testGivenThreeStoredWords_WhenCallDeleteWordWithFavoriteWordAsParameter_ThenShouldHaveTwoWords() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordOne = LocalWord(word: "word one",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordTwo = LocalWord(word: "word two",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordThree = LocalWord(word: "word three",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //Given
        localDictionaryService.saveWord(wordOne)
        localDictionaryService.saveWord(wordTwo)
        localDictionaryService.saveWord(wordThree)
        localDictionaryService.fetchWords()
        //When
        let wordToDelete = localDictionaryService.favoriteWords[0]
        localDictionaryService.deleteWord(wordToDelete)
        //Then
        XCTAssertEqual(localDictionaryService.favoriteWords.count, 2)
    }

    func testGivenThreeStoredWords_WhenCallDeleteWordWithStringAsParameter_ThenSouldBeHaveTwoWords() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordOne = LocalWord(word: "word one",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordTwo = LocalWord(word: "word two",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordThree = LocalWord(word: "word three",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //Given
        localDictionaryService.saveWord(wordOne)
        localDictionaryService.saveWord(wordTwo)
        localDictionaryService.saveWord(wordThree)
        localDictionaryService.fetchWords()
        //When
        localDictionaryService.deleteWord("word one")
        localDictionaryService.fetchWords()
        //Then
        XCTAssertEqual(localDictionaryService.favoriteWords.count, 2)
    }

    func testGivenThreeStoredWords_WhenCallDeleteWordAsFavoriteWordNilAsParameter_ThenShouldHaveThreeWordsStored() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordOne = LocalWord(word: "word one",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordTwo = LocalWord(word: "word two",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordThree = LocalWord(word: "word three",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //Given
        localDictionaryService.saveWord(wordOne)
        localDictionaryService.saveWord(wordTwo)
        localDictionaryService.saveWord(wordThree)
        localDictionaryService.fetchWords()
        //When
        let wordToDelete: FavoriteWord? = nil
        localDictionaryService.deleteWord(wordToDelete)
        //Then
        XCTAssertEqual(localDictionaryService.favoriteWords.count, 3)
    }

    func testGivenThreeStoredWords_WhenCallDeleteWordWithWordThatNotExist_ThenShouldHaveThreeWordsStored() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordOne = LocalWord(word: "word one",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordTwo = LocalWord(word: "word two",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordThree = LocalWord(word: "word three",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //Given
        localDictionaryService.saveWord(wordOne)
        localDictionaryService.saveWord(wordTwo)
        localDictionaryService.saveWord(wordThree)
        localDictionaryService.fetchWords()
        //When
        let wordToDelete = "word that not exist"
        localDictionaryService.deleteWord(wordToDelete)
        localDictionaryService.fetchWords()
        //Then
        XCTAssertEqual(localDictionaryService.favoriteWords.count, 3)
    }

    func testGivenAnLocalWordSaved_WhenCallFetchWords_ThenShoulHaveTheExpectValues() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)

        let wordExpected = "&MNt#49kJ&dgkN4ah@5z^TwS"
        let phoneticExpected = "Jkp6Sam%qNu82R7gVg3dn$rZ"
        let audioExpected = "df%6YEx*NNxTHj6S5H*!359@".data(using: .utf8)
        let originExpected = "F6GG625w2!hTFD6uEbM35xfK"
        let definitionExpected = "2@PDa545MTmS^hdd8#Nt*XNj"
        let urlAudioExpected = "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3"
        let synonymsExpected = "mg$m862VG*u6a6haEaa^J%@5"
        let antonymsExpected = "^Qt6#3yff@8j3pXSNRAymE7w"
        let examplesExpected = "*CywC8RhM6#mEJdYbqzCJ7@V"

        let wordTest = LocalWord(word: "&MNt#49kJ&dgkN4ah@5z^TwS",
                             phonetic: "Jkp6Sam%qNu82R7gVg3dn$rZ",
                             audio: "df%6YEx*NNxTHj6S5H*!359@".data(using: .utf8),
                             origin: "F6GG625w2!hTFD6uEbM35xfK",
                             definition: "2@PDa545MTmS^hdd8#Nt*XNj",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "mg$m862VG*u6a6haEaa^J%@5",
                             antonyms: "^Qt6#3yff@8j3pXSNRAymE7w",
                             examples: "*CywC8RhM6#mEJdYbqzCJ7@V")
        //Given
        localDictionaryService.saveWord(wordTest)
        //When
        localDictionaryService.fetchWords()
        let wordToBeTested =  localDictionaryService.favoriteWords[0]
        //Then
        XCTAssertEqual(wordToBeTested.word, wordExpected)
        XCTAssertEqual(wordToBeTested.phonetic, phoneticExpected)
        XCTAssertEqual(wordToBeTested.audio, audioExpected)
        XCTAssertEqual(wordToBeTested.origin, originExpected)
        XCTAssertEqual(wordToBeTested.definition, definitionExpected)
        XCTAssertEqual(wordToBeTested.urlAudio, urlAudioExpected)
        XCTAssertEqual(wordToBeTested.synonyms, synonymsExpected)
        XCTAssertEqual(wordToBeTested.antonyms, antonymsExpected)
        XCTAssertEqual(wordToBeTested.examples, examplesExpected)
    }

    func testGivenEmptyFavoritesWordsList_WhenCallFetchWords_ThenListOfFavoritesWordsShouldBeEmpty() {
        let coreData = FakeCoreDataStack()
        //Given
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        //When
        localDictionaryService.fetchWords()
        //Then
        XCTAssertTrue(localDictionaryService.favoriteWords.isEmpty)
    }

    func testGivenASavedWord_WhenCheckIfItExist_ThenTheResultShouldBeTrue() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordName = "Num6qT38kz%w7&2W2SDQMh7^KQzpv2^"
        let wordTest = LocalWord(word: "Num6qT38kz%w7&2W2SDQMh7^KQzpv2^",
                             phonetic: "Jkp6Sam%qNu82R7gVg3dn$rZ",
                             audio: "df%6YEx*NNxTHj6S5H*!359@".data(using: .utf8),
                             origin: "F6GG625w2!hTFD6uEbM35xfK",
                             definition: "2@PDa545MTmS^hdd8#Nt*XNj",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "mg$m862VG*u6a6haEaa^J%@5",
                             antonyms: "^Qt6#3yff@8j3pXSNRAymE7w",
                             examples: "*CywC8RhM6#mEJdYbqzCJ7@V")
        //Given
        localDictionaryService.saveWord(wordTest)
        //When
        let wordExist = localDictionaryService.controlWord(wordName)
        //Then
        XCTAssertTrue(wordExist)
    }

    func testGivenASavedWord_WhenCheckIfItExistWithStringNil_ThenTheResultShouldBeFalse() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordTest = LocalWord(word: "Num6qT38kz%w7&2W2SDQMh7^KQzpv2^",
                             phonetic: "Jkp6Sam%qNu82R7gVg3dn$rZ",
                             audio: "df%6YEx*NNxTHj6S5H*!359@".data(using: .utf8),
                             origin: "F6GG625w2!hTFD6uEbM35xfK",
                             definition: "2@PDa545MTmS^hdd8#Nt*XNj",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "mg$m862VG*u6a6haEaa^J%@5",
                             antonyms: "^Qt6#3yff@8j3pXSNRAymE7w",
                             examples: "*CywC8RhM6#mEJdYbqzCJ7@V")
        //Given
        localDictionaryService.saveWord(wordTest)
        //When
        let wordExist = localDictionaryService.controlWord(nil)
        //Then
        XCTAssertFalse(wordExist)
    }

    func testGivenASavedWord_WhenCheckIfItExistWithWrongName_ThenTheResultShouldBeFalse() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wrongName = "Q!2J@4se$6s2nANmZVbgjAU^mTqKXk#"
        let wordTest = LocalWord(word: "Num6qT38kz%w7&2W2SDQMh7^KQzpv2^",
                             phonetic: "Jkp6Sam%qNu82R7gVg3dn$rZ",
                             audio: "df%6YEx*NNxTHj6S5H*!359@".data(using: .utf8),
                             origin: "F6GG625w2!hTFD6uEbM35xfK",
                             definition: "2@PDa545MTmS^hdd8#Nt*XNj",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "mg$m862VG*u6a6haEaa^J%@5",
                             antonyms: "^Qt6#3yff@8j3pXSNRAymE7w",
                             examples: "*CywC8RhM6#mEJdYbqzCJ7@V")
        //Given
        localDictionaryService.saveWord(wordTest)
        //When
        let wordExist = localDictionaryService.controlWord(wrongName)
        //Then
        XCTAssertFalse(wordExist)
    }

    func testGivenMaincontextIncorrect_WhenTryCallSaveWord_ThenShouldHaveProblemSaving() {
        //Given
        let persistentContainer = NSPersistentContainer(name: "I do not exist")
        let mainContext = persistentContainer.viewContext
        let localDictionaryService = LocalDictionaryService(mainContext: mainContext)
        let wordTest = LocalWord(word: "Num6qT38kz%w7&2W2SDQMh7^KQzpv2^",
                             phonetic: "Jkp6Sam%qNu82R7gVg3dn$rZ",
                             audio: "df%6YEx*NNxTHj6S5H*!359@".data(using: .utf8),
                             origin: "F6GG625w2!hTFD6uEbM35xfK",
                             definition: "2@PDa545MTmS^hdd8#Nt*XNj",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "mg$m862VG*u6a6haEaa^J%@5",
                             antonyms: "^Qt6#3yff@8j3pXSNRAymE7w",
                             examples: "*CywC8RhM6#mEJdYbqzCJ7@V")
        //Given
        localDictionaryService.saveWord(wordTest)
        //Then
        XCTAssertTrue(localDictionaryService.problemSaving)
    }

    func testGivenMaincontextIncorrect_WhenTryCallFetchWords_ThenShouldHaveProblemFetching() {
        //Given
        let persistentContainer = NSPersistentContainer(name: "I do not exist")
        let mainContext = persistentContainer.viewContext
        let localDictionaryService = LocalDictionaryService(mainContext: mainContext)
        //Given
        localDictionaryService.fetchWords()
        //Then
        XCTAssertTrue(localDictionaryService.problemFetching)
    }

    func testGivenMaincontextIncorrect_WhenTryCallControlWords_ThenShouldHaveProblemFetching() {
        //Given
        let persistentContainer = NSPersistentContainer(name: "I do not exist")
        let mainContext = persistentContainer.viewContext
        let localDictionaryService = LocalDictionaryService(mainContext: mainContext)
        //Given
        let test = localDictionaryService.controlWord("word")
        //Then
        XCTAssertTrue(localDictionaryService.problemFetching)
        XCTAssertEqual(test, false)
    }

    func testGivenMaincontextIncorrect_WhenTryCallDeleteWord_ThenShouldHaveProblemFetching() {
        //Given
        let persistentContainer = NSPersistentContainer(name: "I do not exist")
        let mainContext = persistentContainer.viewContext
        let localDictionaryService = LocalDictionaryService(mainContext: mainContext)
        //Given
        localDictionaryService.deleteWord("word")
        //Then
        XCTAssertTrue(localDictionaryService.problemFetching)
    }

    func testGivenThreeStoredWords_WhenCallClearFavoriteWords_ThenFavoriteWordShouldBeEmpty() {
        let coreData = FakeCoreDataStack()
        let localDictionaryService = LocalDictionaryService(mainContext: coreData.mainContext)
        let wordOne = LocalWord(word: "word one",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordTwo = LocalWord(word: "word two",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        let wordThree = LocalWord(word: "word three",
                             phonetic: "phonetic test",
                             audio: "audio test".data(using: .utf8),
                             origin: "origin test",
                             definition: "definition test",
                             urlAudio: "https://api.dictionaryapi.dev/media/pronunciations/en/test.mp3",
                             synonyms: "synonymOne \n synonymTwo",
                             antonyms: "antonymOne \n antonymTwo",
                             examples: "This is an example of a test.")
        //Given
        localDictionaryService.saveWord(wordOne)
        localDictionaryService.saveWord(wordTwo)
        localDictionaryService.saveWord(wordThree)
        localDictionaryService.fetchWords()
        //When
        localDictionaryService.clearFavorites()
        
        //Then
        XCTAssertTrue(localDictionaryService.favoriteWords.isEmpty)
    }
}
