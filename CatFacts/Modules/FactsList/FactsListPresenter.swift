//
//  FactListPresenter.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

public protocol FactListViewable: Viewable {
    func reloadData()
}

public protocol FactsListPresenterProtocol: Presentable {
    var catFactsFullList: [CatFact] {get}
    var catFactsFilteredList: [CatFact] {get}
    var isSearching: Bool {get}
    
    func search(for text: String)
    func fetchCatFacts()
    func setCatFacts(facts catFacts: [CatFact])
    func getCatFacts() -> [CatFact]
}

final class FactsListPresenter: FactsListPresenterProtocol {
    
    typealias View = FactListViewable
    weak var view: FactListViewable?
    
    private let service: ListServices
    private(set) var catFactsFullList: [CatFact] = []
    private(set) var catFactsFilteredList: [CatFact] = []

    private(set) var isSearching = false
    
    /// intisialising using the service, DI
    /// - Parameter FactsApi: service to call the API
    init(service factsService: ListServices) {
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
    
    func search(for text: String) {
        if text.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            catFactsFilteredList = catFactsFullList.filter({$0.text.contains(text)})
        }
        view?.reloadData()
    }
    
    /// fetching cat facts from API
    func fetchCatFacts() {
        service.getFacts { [weak self] list, error in
            self?.view?.stopLoading()
            guard error == nil else {
                self?.view?.didFail(with: error ?? NSError(domain: "Fetching Facts", code: -1, userInfo: ["message":"general error"]))
                return
            }
            self?.setCatFacts(facts: list ?? [])
            self?.view?.didSucceed()
        }
    }
    
    func setCatFacts(facts catFacts: [CatFact]) {
        self.catFactsFullList = catFacts
    }
    
    func getCatFacts() -> [CatFact] {
        return isSearching ? catFactsFilteredList : catFactsFullList
    }
    
}
