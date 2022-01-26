//
//  EndPoints.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

protocol EndPoint {
    var path: String {get}
}
enum EndPoints: EndPoint {
    case getFacts
    
    var path: String {
        switch self {
        case .getFacts:
            return "https://api.jsonbin.io/b/6064467b418f307e2585ef1b"
        }
    }
}
