//
//  Endpoint.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var method: String { get }
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
extension Endpoint {
    var apiKey: String {
        return ""
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        //components.query = apiKey
        return components
    }
    
    var request: URLRequest {
       // let url = urlComponents.url!
        var urlRequest = URLRequest(url: URL(string: base + path)!)
        urlRequest.httpMethod = method
        //urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        // Common Headers
        //urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        //urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        return urlRequest
    }

}
