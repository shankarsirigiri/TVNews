//
//  MoviesProvider.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import Foundation
import Combine

final class ChannelsProvider: ObservableObject {
    
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    
    // MARK:- Publishers
    @Published var channels: [Channel] = []

    // MARK:- Private properties
    private let client = ChannelClient()
    
    // MARK:- Loading Indicator
    @Published var loading = true
    
    init() {
        cancellable = client.getFeed(.top).sink(receiveCompletion:{
            completion in print(completion)
        }, receiveValue: { (ChannelFeedResult) in
            //print(ChannelFeedResult)
            self.channels = ChannelFeedResult
            self.loading = false
        })
    }
    func fetchChannels(type: ChannelFeed) {
        cancellable = client.getFeed(type).sink(receiveCompletion:{
            completion in print(completion)
        }, receiveValue: { (ChannelFeedResult) in
            print(ChannelFeedResult.count)
            self.channels = ChannelFeedResult
            self.loading = false
        })
    }
}
