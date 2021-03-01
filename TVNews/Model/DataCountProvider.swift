//
//  DataCountProvider.swift
//  TVNews
//
//  Created by SpringML_IOS on 01/03/21.
//

import Foundation
import Combine

final class DataCountProvider: ObservableObject {
    
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    
    // MARK:- Publishers
    @Published var dtCount: DataCount = DataCount()

    // MARK:- Private properties
    private let client = ChannelClient()
    
    // MARK:- Loading Indicator
    @Published var loading = true
    
    init() {
        cancellable = client.getCount(.dataCount).sink(receiveCompletion:{
            completion in print(completion)
        }, receiveValue: { ChannelFeedResult in
            //print(ChannelFeedResult)
            self.dtCount = ChannelFeedResult
            self.loading = false
        })
    }
    func fetchDataCount(type: ChannelFeed) {
        cancellable = client.getCount(type).sink(receiveCompletion:{
            completion in print(completion)
        }, receiveValue: { ChannelFeedResult in
            self.dtCount = ChannelFeedResult
            self.loading = false
        })
    }
}
