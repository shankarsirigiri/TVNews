//
//  Filter.swift
//  TVNews
//
//  Created by SpringML_IOS on 25/02/21.
//

import Foundation

struct Filter: Codable, Hashable {
    var countries: [Country]?
}
struct Country: Codable, Hashable {
    var id: String?
    var time: Int?
    var updateTime: Int?
    var name: String?
    var code: String?
    var timezoneId: String?
}
