//
//  MovieFeed.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation

enum ChannelFeed {
    case yourmix
    case yourlive
    case stories
    case top
    case live
    case demand
    case popular
    case more
    case dataCount
    case filters
    case playlistId
    case search
}
extension ChannelFeed: Endpoint {
    var method: String {
        switch self {
            case .search:
                return "POST"
            default:
                return "GET"
        }
    }

    var base: String {
        return "http://78.128.60.15:8080/api/channels/app"
    }
    
    var path: String {
        switch self {
            case .dataCount: return "/dataCount"
            case .filters: return "/filters"
            case .live: return "/get/LIVE"
            case .top: return "/get/TOP"
            case .demand: return "/get/DEMAND"
            case .popular: return "/get/POPULAR"
            case .more: return "/get/MORE"
            case .playlistId: return "/get/videos/"
            case .search: return "/search"
            case .yourmix: return ""
            case .yourlive: return ""
            case .stories: return ""
                
        }
    }
}
