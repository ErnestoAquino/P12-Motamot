//
//  DictionaryServiceTestCase.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 14/08/2022.
//

import XCTest
@testable import Motamot

class DictionaryServiceTestCase: XCTestCase {

    func testGivenWordWithoutValue_WhenCallGetDefinition_ThenTheWarningMessageShouldBeCalled() {
        let delegate = DictionaryServiceMockDelegate()
        let dictionaryService = DictionaryService()
        dictionaryService.viewDelegate = delegate

        //Given
        let word: String? = nil
        //When
        dictionaryService.getDefinition(word: word)
        //Then
        XCTAssertTrue(delegate.warningMessageIsCalled)
    }

    func testGivenAnStringWithOnlyBlankSpaces_WhenCallGetDefinition_ThenWarningMessageShouldBeCalled() {
        
    }

}
