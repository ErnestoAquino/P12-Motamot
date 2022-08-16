//
//  NetworkManagerTestCase.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 12/08/2022.
//

import XCTest
@testable import Motamot

/**
 * NetworkManagerTestCase:
 *
 * Tests created for the NetworkManager class.
 */
class NetworkManagerTestCase: XCTestCase {
    private var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Waiting for finish.")
    }

    private func createUrlForTest() -> URL? {
        let urlTest = URL(string: "https://urlForTests.com/")
        return urlTest
    }

//MARK: -Tests

    func testGivenErrorInResponse_WhenCallingGetInformation_ThenShouldHaveAnError() {
        //Given
        let session = URLSessionFake(data: nil, response: nil, error: FakeResponse.anError)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        let url = createUrlForTest()
        //When
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            //Then
            XCTAssertNotNil(error)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenUrlNil_WhenCallGetInformation_ThenCompletionHandlerShouldBeNil() {
        //Given
        let url: URL? = nil
        let session = URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            //Then
            XCTAssertNil(error)
            XCTAssertNil(dictionaryResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenNoDataInResponse_WhenCallGetInformation_ThenCompletionHandlerShoultBeNil() {
        let url = createUrlForTest()
        //Given
        let data: Data? = nil
        let session = URLSessionFake(data: data, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            //Then
            XCTAssertNil(error)
            XCTAssertNil(dictionaryResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWrongStatusCode_WhenCallGetInformation_ThenCompletionHandlerShouldBeNil() {
        let url = createUrlForTest()
        //Given
        let session = URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseFail, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            //Then
            XCTAssertNil(error)
            XCTAssertNil(dictionaryResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenIcorrectDataReceived_WhenCallGetInformation_ThenCompletionHandlerShouldBeNil() {
        let url = createUrlForTest()
        //Given
        let session = URLSessionFake(data: FakeResponse.incorrectData, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            XCTAssertNil(error)
            XCTAssertNil(dictionaryResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenCorrectResponse_WhenCallGetInformation_ThenShouldHaveCorrectResponse() {
        let url = createUrlForTest()
        //Given
        let session = URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getInformation(url: url) { dictionaryResponse, error in
            XCTAssertNil(error)
            XCTAssertNotNil(dictionaryResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenStringUrlNil_WhenCallGetAudio_ThenDataAudioResponseShouldBeNil() {
        //Given
        let stringUrl: String? = nil
        let session = URLSessionFake(data: FakeResponse.audioData, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getAudio(stringUrl) { audioResponse in
            //Then
            XCTAssertNil(audioResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenAnError_WhenCallGetAudio_ThenAudioDataResponseShouldBeNil() {
        //Given
        let session = URLSessionFake(data: FakeResponse.audioData, response: FakeResponse.responseOK, error: FakeResponse.anError)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getAudio(FakeResponse.url) { audioResponse in
            //Then
            XCTAssertNil(audioResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenStatusCodeErrorInResponse_WhenCallGetAudio_ThenAudioDataResponseShouldBeNil() {
        //Given
        let session = URLSessionFake(data: FakeResponse.audioData, response: FakeResponse.responseFail, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getAudio(FakeResponse.url) { audioResponse in
            //Then
            XCTAssertNil(audioResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenNoDataInResponse_WhenCallGetAudio_ThenAudioDataResponseShouldBeNil() {
        //Given
        let session = URLSessionFake(data: nil, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getAudio(FakeResponse.url) { audioResponse in
            //Then
            XCTAssertNil(audioResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenCorrectResponse_WhenCallGetAudio_ThenDataAudioResponseShouldBeNoNil() {
        //Given
        let session = URLSessionFake(data: FakeResponse.audioData, response: FakeResponse.responseOK, error: nil)
        let networkManager = NetworkManager<DictionaryResponse>(networkManagerSession: session)
        //When
        networkManager.getAudio(FakeResponse.url) { audioResponse in
            //Then
            XCTAssertNotNil(audioResponse)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
