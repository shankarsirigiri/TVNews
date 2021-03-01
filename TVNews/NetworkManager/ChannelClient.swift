//
//  MovieClient.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation
import Combine


final class ChannelClient: CombineAPI {
    
    // 1
    let session: URLSession
    
    // 2
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // 3
    func getFeed(_ feedKind: ChannelFeed) -> AnyPublisher<[Channel], Error> {
        execute(feedKind.request, decodingType: [Channel].self, retries: 2)
    }
    
    //Fetching Channels count
    func getCount(_ feedKind: ChannelFeed) -> AnyPublisher<DataCount, Error> {
        execute(feedKind.request, decodingType: DataCount.self, retries: 2)
    }
}

protocol CombineAPI {
    var session: URLSession { get }
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue,
                    retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension CombineAPI {
    
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main,
                    retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseUnsuccessful
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
}
