//
//  NetworkManager.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 27/07/2022.
//

import Foundation

public final class NetworkManager<T: Decodable> {

    private var task: URLSessionDataTaskProtocol?
    private var session: URLSessionProtocol

    init (networkManagerSession: URLSessionProtocol) {
        self.session = networkManagerSession
    }

    /**
     This method retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
     
     - parameter request:           A URL request object that provides the URL.
     - parameter completionHandler: This completion handler takes the following parameters:
     T? : The data returned by the server like a structure decodable
     type. Error? :
      An error object that indicates why the request failed, or nil if the request was successful.
     */
    public func getInformation(url: URL?, completionHandler: @escaping ([T]?, Error?) -> Void) {
        guard let url = url else {
            completionHandler(nil, nil)
            return
        }
        task?.cancel()
        task = session.dataTaskWithURL(url, completion: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    completionHandler(nil, nil)
                    return
                }
                let decoderData = JSONDecoder()
                decoderData.keyDecodingStrategy = .useDefaultKeys
                decoderData.dateDecodingStrategy = .secondsSince1970
                guard let informationObtained = try? decoderData.decode([T]?.self, from: data) else {
                    completionHandler(nil, nil)
                    return
                }
                completionHandler(informationObtained, error)
            }
        })
        task?.resumeWithRequest()
    }

    /**
     This method retrives an audio from the url passed in parameter.
     
     - parameter urlString:         String for request.
     - parameter completionHandler: Data? : The data returned by the server if the operation was successful or nil if there was an error
     */
    public func getAudio(_ urlString: String?, completionHandler: @escaping (Data?)-> Void) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        task?.cancel()
        task = session.dataTaskWithURL(url, completion: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = data else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
            }
        })
        task?.resumeWithRequest()
    }
}
