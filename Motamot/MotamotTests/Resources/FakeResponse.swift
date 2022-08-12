//
//  FakeResponse.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 12/08/2022.
//

import Foundation

class FakeResponse {

    static let emptyRequest: URLRequest? = nil
    static let incorrectData = "Error".data(using: .utf8)
    static let audioData = "audio pronunciation".data(using: .utf8)

    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponse.self)
        guard let url = bundle.url(forResource: "DictionaryResponse", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }

    static var responseOK: HTTPURLResponse? {
        guard let url = URL(string: "www.openclassrooms.com") else {
            return nil
        }
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return response
    }

    static var responseFail: HTTPURLResponse? {
        guard let url = URL(string: "www.openclassrooms.com") else {
            return nil
        }
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        return response
    }

}
