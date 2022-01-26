//
//  CatFactsTests.swift
//  CatFactsTests
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import XCTest
@testable import CatFacts

class CatFactsPresenterTests: XCTestCase {
    
    private var factsListPresenter: FactsListPresenter!
    private var fetchCatFactsAPIExpectation: XCTestExpectation!
    
    func testFetchingFacts() {
        let factsAPI = FactsApi()

        // Create an expectation for a task.
        fetchCatFactsAPIExpectation = expectation(description: "Feching Cat Facts API")
        factsListPresenter = FactsListPresenter(service: factsAPI)
        factsListPresenter.attachView(self)
        factsListPresenter.fetchCatFacts()
        
        wait(for: [fetchCatFactsAPIExpectation!], timeout: 10.0)
    }
    
    func testSpanLessThan90() {
        /**
         18th of Jan 2022 == 1642464000
         26th of Jan 2022 == 1643155200
         will check the span between the two if less than 90 days, if it returns true then success else fails
         **/
        let span = DateHelper.isSpanIsLessThan90Days(
            fromDate: Date(timeIntervalSince1970:1642464000),
            toDate: Date(timeIntervalSince1970: 1643155200))
            XCTAssert(span, "less than 90 days :)")
    }

}

extension CatFactsPresenterTests: FactListViewable {
    
    func didSucceed() {
        XCTAssertNotNil(factsListPresenter?.getCatFacts())
        XCTAssertTrue(factsListPresenter?.getCatFacts().count ?? 0 > 0)
        fetchCatFactsAPIExpectation?.fulfill()
    }
    
    func didFail(with error: Error) {
        XCTAssertNotNil(nil)
        XCTAssertTrue(false)
        fetchCatFactsAPIExpectation?.fulfill()
    }
    
}
