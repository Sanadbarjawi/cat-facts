//
//  FactListPresenter.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

protocol FactListViewable: Viewable {
    func reloadData()
}

final class FactsListPresenter: Presentable {
    
    typealias View = FactListViewable
    weak var view: FactListViewable?
    
    private let service: FactsApi
    private var catFactsList: [CatFact] = []
    private var filteredList: [CatFact] = []

    private var isSearching = false
    
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
    
    func search(for text: String) {
        if text.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredList = catFactsList.filter({$0.text.contains(text)})
        }
        view?.reloadData()
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
            self?.catFactsList = list ?? []
            self?.view?.didSucceed()
        }
    }
    
    func getCatFacts() -> [CatFact] {
        return isSearching ? filteredList : catFactsList
    }
    
}
