//
//  URLSessionExtension.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 27/07/2022.
//

import Foundation

// URL Session protocol adn URL Session protocol allow to make the classes testable. Allowing the injection of dependencies.
extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(_ request: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completion) as URLSessionDataTaskProtocol
    }
    
    func dataTaskWithRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completion) as URLSessionDataTaskProtocol
    }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {
    func resumeWithRequest() {
        resume()
    }
}

protocol URLSessionProtocol {
    func dataTaskWithRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
    func dataTaskWithURL(_ request: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resumeWithRequest()
    func cancel()
}
