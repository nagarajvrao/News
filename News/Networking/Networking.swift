//
//  Networking.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import Foundation
import Combine

protocol CombineAPI {
    var session: URLSession { get }
    func execute<T>(_ request: URLRequest, decodingType: T.Type, queue: DispatchQueue) -> AnyPublisher<T, Error> where T: Decodable
}

enum APIError: Error {
    case responseUnsuccessful
}

extension CombineAPI {
    
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main) -> AnyPublisher<T, Error> where T: Decodable {
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseUnsuccessful
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}

struct APIClient: CombineAPI {
    
    let session: URLSession
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
}
