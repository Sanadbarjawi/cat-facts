//
//  Cat.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import Foundation

struct CatFact: Decodable {
    var status: Status
    let text: String
    let createdAt: Date
    
    //doing our own implementation here to assign `isNew` variable while initialization the Fact object
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Status.self, forKey: .status)
        text = try values.decode(String.self, forKey: .text)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
        //assigning `isNew` property in the initializer for performance reasons and to avoid any later iterations that would be causing a time complexity of O(n)
        status.isNew = DateHelper.isSpanIsLessThan90Days(fromDate: createdAt, toDate: Date())
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case text
        case createdAt
    }
}

struct Status: Decodable {
    let verified: Bool
    let sentCount: Int
    
    //placing our own extra functionality `isNew` variable that's used to determine the Fact date status.
    var isNew: Bool?
}

