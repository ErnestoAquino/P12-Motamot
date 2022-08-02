//
//  DictionaryResponse.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 27/07/2022.
//

import Foundation

/**
 * DictionaryResponse:
 *
 * Structure to retrieve the response from: https://dictionaryapi.dev
 */
struct DictionaryResponse: Decodable {
    var word: String?
    var phonetic: String?
    var phonetics: [Phonetic]?
    var meanings: [Meaning]?
    var sourceUrls: [String]?
}

struct Phonetic: Decodable {
    var text: String?
    var audio: String?
    var sourceUrl: String?
}

struct Meaning: Decodable {
    var definitions: [Definition]?
    var synonyms: [String]?
    var antonyms: [String]?
}

struct Definition: Decodable {
    var definition: String?
    var synonyms: [String]?
    var antonyms: [String]?
}

struct LocalWord {
    var word: String
    var phonetic: String?
    var audio: Data?
    var origin: String?
    var definition: String?
    var urlAudio: String?
}
