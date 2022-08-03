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

    init(_ session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getDefinition(word: String?) {
        guard let word = word else {return}
        let wordWithoutSpaces = trimmingAllSpaces(word)
        guard wordWithoutSpaces.isEmpty == false else {
            warningMessage("Mot a mot, it is a dictionary.\nPlease enter a word like: Love")
            return
        }
        let url = createURL(word, type: .urlForDefinition)
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
     If you want a URL for the audio select:
     ```
     createURL(url, type: .urlForAudio)//The function will create a url with the string passed in parameter.
     ```

     - parameter stringURL: String optional to create the URL
     - parameter type:      Type of url you want to obtain.
     
     - returns: Optional URL of the desired type.
     */
    private func createURL(_ stringURL: String?, type: UrlType) -> URL?{
        let endPoint = "https://api.dictionaryapi.dev/api/v2/entries/en/"
        guard let stringURL = stringURL else {return nil}

        switch type {
        case .urlForDefinition:
            let url = URL(string: endPoint + stringURL)
            return url
        case .urlForAudio:
            let url = URL(string: stringURL)
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

    private func createLocalWord(_ responseDictionary: [DictionaryResponse]) {
        let word = responseDictionary[0].word
        var phonetic =  responseDictionary[0].phonetics?[0].text
        let audioURL = responseDictionary[0].phonetics?[0].audio
        let origin = responseDictionary[0].origin
        let definition = responseDictionary[0].meanings?[0].definitions?[0].definition

        if phonetic == nil {
            phonetic = responseDictionary[0].phonetics?[1].text
        }
        let localWord = LocalWord(word: word,
                                  phonetic: phonetic,
                                  audio: nil,
                                  origin: origin,
                                  definition: definition,
                                  urlAudio: audioURL)
        myLocalWord =  localWord
        getAudio(myLocalWord?.urlAudio)
    }

    private func getAudio(_ stringWithUrl: String?) {
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        networkManager.getAudio(stringWithUrl) { data in
            guard let data = data else {return}
            self.myLocalWord?.audio = data
            self.printWord(self.myLocalWord)
        }
    }

//MARK: - Funciones de test

    private func printWord(_ word: LocalWord?) {
        let text =
        """
        Word: \(word?.word ?? "---")
        Phonetic: \(word?.phonetic ?? "---")
        Audio: \(word?.audio?.description ?? "---")
        Origin: \(word?.origin ?? "---")
        Definition: \(word?.definition ?? "---")
        urlAudio:  \(word?.urlAudio ?? "---")
        """
        print(text)
    }
}
