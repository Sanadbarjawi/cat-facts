//
//  Viewable.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

public protocol Viewable: NSObjectProtocol {
    func didSucceed()
    func startLoading()
    func stopLoading()
    func didFail(with error: NSError)
}

extension Viewable {
    func didSucceed() { }
    func startLoading() { }
    func stopLoading() { }
    func didFail(with error: NSError) { }
}
