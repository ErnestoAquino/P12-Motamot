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
        print(url as Any)
        
    }


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
}
