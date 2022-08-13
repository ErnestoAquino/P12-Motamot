//
//  URLSessionFake.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 12/08/2022.
//

import Foundation
@testable import Motamot

/**
 * URLSessionFake:
 *
 * This class is a mock of the URL Session class, it is initialized with the necessary information to make the tests.
 */
class URLSessionFake: URLSessionProtocol {

    var data: Data?
    var response: URLResponse?
    var error: Error?

    init (data: Data?,response: URLResponse?,error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    //TODO: - This function may no be required.
    func dataTaskWithRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error)
        task.completionHandler = completion
        return task
    }

    func dataTaskWithURL(_ request: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error)
        task.completionHandler = completion
        return task
    }
}

/**
 * URLSessionDataTaskFake:
 *
 * This class is a mock of the  URLSessionDataTask. The resume() method only resends the information that has been entered at the time of initialization.
 */
class URLSessionDataTaskFake: URLSessionDataTaskProtocol {

    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?

    init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = responseError
    }

    func resumeWithRequest() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    func cancel() {}
}
