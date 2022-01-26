//
//  CatFactsSearchTests.swift
//  CatFactsTests
//
//  Created by sanad barjawi on 26/01/2022.
//

import XCTest
@testable import CatFacts

class CatFactsSearchTests: XCTestCase {

    private var factsListPresenter: FactsListPresenter?
    private var factsAPI: ListServices?
    
    override func setUp() {
        factsAPI = ListServices()
        factsListPresenter = FactsListPresenter(service: factsAPI!)
    }
    
    func testSearchWhenEmpty() {
        let mockedfacts: [CatFact] = []
        factsListPresenter?.setCatFacts(facts: mockedfacts)
        factsListPresenter?.search(for: "some fact")
        XCTAssertTrue(factsListPresenter?.getCatFacts().count ?? 0 == 0,
                      "search results empty")
    }
    
    func testEmptySearch() {
        let mockedfacts: [CatFact] = []
        factsListPresenter?.setCatFacts(facts: mockedfacts)
        factsListPresenter?.search(for: "")
        XCTAssertTrue(factsListPresenter?.getCatFacts().count ?? 0 == 0,
                      "search results empty")
    }
    
    func testSearchWhenFoundResults() {
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
        factsListPresenter?.search(for: "fact2")
        XCTAssertTrue(factsListPresenter?.catFactsFilteredList.count ?? 0 > 0,
                      "found search results")
    }
    
    override func tearDown() {
        factsAPI = nil
        factsListPresenter = nil
    }

}
