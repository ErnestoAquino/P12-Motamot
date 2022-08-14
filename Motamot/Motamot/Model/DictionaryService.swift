//
//  DictionaryService.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 26/07/2022.
//

import Foundation

class DictionaryService {
    weak var viewDelegate: SearchDelegate?
    private let session: URLSessionProtocol
    var myLocalWord: LocalWord?
    var wordsSearched: [LocalWord] = []

    init(_ session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /**
     This method retrieves the word and makes a request to the Free Dictionary API to retrieve the definition.
     
     - parameter word: String word for which you want to obtain the definition.
     */
    func getDefinition(word: String?) {
        guard let word = word else {
            warningMessage("Mot a mot, it is a dictionary.\nPlease enter a word like: Love")
            return
        }
        let wordWithoutSpaces = trimmingAllSpaces(word)
        guard wordWithoutSpaces.isEmpty == false else {
            warningMessage("Mot a mot, it is a dictionary.\nPlease enter a word like: Love")
            return
        }
        let url = createURL(wordWithoutSpaces, type: .urlForDefinition)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        showActivityIndicator(true)
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            guard error == nil,
                  let dictionaryResponse = dictionaryResponse else {
                self.warningMessage("Sorry.\nWe can finds definitions for this word.")
                self.showActivityIndicator(false)
                return
            }
            self.createLocalWord(dictionaryResponse)
            self.showActivityIndicator(false)
        }
    }


    /**
     This function creates an optional URL.

     If you want a URL to get a definition select
     ```
     createURL(word, type: .urlForDefinition)//The function will create the URL using the endpoind + String.
     ```
     - parameter stringURL: String optional to create the URL
     - parameter type:      Type of url you want to obtain.
     
     - returns: Optional URL of the desired type.
     */
    private func createURL(_ stringURL: String, type: UrlType) -> URL?{
        let endPoint = "https://api.dictionaryapi.dev/api/v2/entries/en/"
        switch type {
        case .urlForDefinition:
            let url = URL(string: endPoint + stringURL)
            return url
        }
    }

    /**
     This function removes whitespace from a string.
     
     - parameter string: String with spaces to be removed.
     
     - returns: String without spaces or line breaks.
     */
    private func trimmingAllSpaces(_ string: String) -> String {
        return string.components(separatedBy: .whitespacesAndNewlines).joined()
    }

  
    /**
     This function retrieves the API response and creates an instance of localWord.
     
     - parameter responseDictionary: Array of dictionaryResponse
     */
    private func createLocalWord(_ responseDictionary: [DictionaryResponse]) {
        var audioURL = ""
        let word = responseDictionary[0].word ?? "N/A"
        let origin = responseDictionary[0].origin ?? "N/A"
        let phonetics: [String] = responseDictionary[0].phonetics?.compactMap({ phonetic in
            phonetic.text
        }) ?? ["N/A"]
        let audios: [String] = responseDictionary[0].phonetics?.compactMap({ phonetic in
            phonetic.audio
        }) ?? ["N/A"]
        let definitions: [String] =  responseDictionary[0].meanings?[0].definitions?.compactMap({ definition in
            definition.definition
        }) ?? ["N/A"]
        let synonyms: [String] = responseDictionary[0].meanings?[0].synonyms ?? ["N/A"]
        let antonyms: [String] = responseDictionary[0].meanings?[0].antonyms ?? ["N/A"]
        let examples: [String] = responseDictionary[0].meanings?[0].definitions?.compactMap({ definition in
            definition.example
        }) ?? ["N/A"]
        if let indexOfUrl = audios.firstIndex(where: {$0.hasPrefix("https")}) {
            audioURL = audios[indexOfUrl]
        }

        let localWord = LocalWord (word: word,
                                   phonetic: phonetics.joined(separator: " | "),
                                   audio: nil,
                                   origin: origin,
                                   definition: definitions.joined(separator: "\n\t• "),
                                   urlAudio: audioURL,
                                   synonyms: synonyms.joined(separator: "\n\t• "),
                                   antonyms: antonyms.joined(separator: "\n\t• "),
                                   examples: examples.joined(separator: "\n\t• "))
        myLocalWord =  localWord
        getAudio(myLocalWord?.urlAudio)
    }

    /**
     This method performs a request to retrieve the audio of the pronunciation.
     
     - parameter stringWithUrl: Url string to make the audio request.
     */
    private func getAudio(_ stringWithUrl: String?) {
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        networkManager.getAudio(stringWithUrl) { data in
            guard let data = data else {
                if let myLocalWord = self.myLocalWord {
                    self.wordsSearched.append(myLocalWord)
                }
                self.goToWordViewController()
                return
            }
            self.myLocalWord?.audio = data
            if let myLocalWord = self.myLocalWord {
                self.wordsSearched.append(myLocalWord)
            }
            self.goToWordViewController()
        }
    }
}
