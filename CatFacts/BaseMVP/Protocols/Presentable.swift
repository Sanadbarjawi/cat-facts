//
//  Presentable.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

public protocol Presentable {
    associatedtype View
    var view: View? {get set}
    func attachView(_ view: View)
    func detachView()
}
