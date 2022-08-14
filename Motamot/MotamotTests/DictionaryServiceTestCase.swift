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
        let delegate = DictionaryServiceMockDelegate()
        let dictionaryService = DictionaryService()
        dictionaryService.viewDelegate = delegate

        //Given
        let word = "                "
        //When
        dictionaryService.getDefinition(word: word)
        //Then
        XCTAssertTrue(delegate.warningMessageIsCalled)
    }

    func testGivenErrorInApiResponse_WhenCallGetDefinition_ThenWarningMessageShouldBeCalled() async {
        let exp = expectation(description: "Wait for function")
        //Given
        let session = URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, error: FakeResponse.anError)
        let delegate = DictionaryServiceMockDelegate()
        let dictionaryService = DictionaryService(session)
        dictionaryService.viewDelegate = delegate
        //When
        dictionaryService.getDefinition(word: "test")
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertTrue(delegate.warningMessageIsCalled)
    }

    func testGivenValidRequestAndWord_WhenCallGetDefinition_ThenLocalWordShouldNotBeNil() async {
        let exp = expectation(description: "Wait for function")
        //Given
        let session = URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, error: nil)
        let dictionaryService = DictionaryService(session)
        //When
        dictionaryService.getDefinition(word: "test")
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertNotNil(dictionaryService.myLocalWord)
    }

    func testGivenResponseWithMissing_WhenCallGetDefinition_ThenLocalWordShouldNotBeNil() async {
        let exp = expectation(description: "Wait for function")
        //Given
        let session = URLSessionFake(data: FakeResponse.dataWithMissingElements, response: FakeResponse.responseOK, error: nil)
        let dictionaryService = DictionaryService(session)
        //When
        dictionaryService.getDefinition(word: "test")
        exp.fulfill()
        await waitForExpectations(timeout: 1)
        //Then
        XCTAssertNotNil(dictionaryService.myLocalWord)
    }

}

