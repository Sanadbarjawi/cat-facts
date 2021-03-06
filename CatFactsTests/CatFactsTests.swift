//
//  CatFactsTests.swift
//  CatFactsTests
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import XCTest
@testable import CatFacts

class CatFactsPresenterTests: XCTestCase {
    
    private var factsListPresenter: FactsListPresenter?
    private var factsAPI: ListServices?
    
    override func setUp() {
        factsAPI = ListServices()
        factsListPresenter = FactsListPresenter(service: factsAPI!)
    }
    
    /// It should correctly reflect whether it has items.
    func testHasUsers() {
        let mockedfacts: [CatFact] = [
            .init(status: .init(verified: true,
                                sentCount: 10, isNew: true),
                  text: "cat fact1", createdAt: Date()),
            .init(status: .init(verified: true,
                                sentCount: 10, isNew: true),
                  text: "cat fact2", createdAt: Date()),
            .init(status: .init(verified: true,
                                sentCount: 10, isNew: true),
                  text: "cat fact3", createdAt: Date())
        ]
        
        factsListPresenter?.setCatFacts(facts: mockedfacts)
        XCTAssertTrue(factsListPresenter?.catFactsFullList.count ?? 0 > 0)
    }
    
    func testEmptyListOfFacts() {
        let mockedfacts: [CatFact] = []
        factsListPresenter?.setCatFacts(facts: mockedfacts)

        XCTAssertEqual(factsListPresenter?.catFactsFullList.count, 0)
    }
    
    override func tearDown() {
        factsAPI = nil
        factsListPresenter = nil
    }
}

