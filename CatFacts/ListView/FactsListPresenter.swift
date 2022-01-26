//
//  FactListPresenter.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

protocol FactListViewable: Viewable {}

final class FactsListPresenter: Presentable {
    
    typealias View = FactListViewable
    weak var view: FactListViewable?
    
    private let service: FactsApi
    private var catFactsList: [CatFact]?
    
    /// intisialising using the service, DI
    /// - Parameter FactsApi: service to call the API
    init(service factsService: FactsApi) {
        self.service = factsService
    }
    
    /// attaching the view responsible to do and reflect UI Changes
    /// - Parameter view: adopting View
    func attachView(_ view: FactListViewable) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    /// fetching cat facts from API
    @objc
    func fetchCatFacts() {
        service.getFacts { [weak self] list, error in
            self?.view?.stopLoading()
            guard error == nil else {
                self?.view?.didFail(with: error ?? NSError(domain: "Fetching Facts", code: -1, userInfo: ["message":"general error"]))
                return
            }
            self?.catFactsList = list
            self?.view?.didSucceed()
        }
    }
    
    func getCatFacts() -> [CatFact] {
        return catFactsList ?? []
    }
    
    private func checkIfFactIsNew(from interval : TimeInterval) -> Bool {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        return abs(day) <= 90
    }
    
}
