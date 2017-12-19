//
//  NetworkService.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/19/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum RequestResult {
    case success(Data)
    case error(Error)
}

enum RequestError: Swift.Error {
    case invalidURL
    case unknownError
}

class NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(url: URL, method: HTTPMethod = .get, body: String = "", headers: [String: String] = [:], completion: @escaping (RequestResult) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: .utf8)
        
        let task = session.dataTask(with: request) { data, response, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let data = data else {
                let _error = error ?? RequestError.unknownError
                completion(.error(_error))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
