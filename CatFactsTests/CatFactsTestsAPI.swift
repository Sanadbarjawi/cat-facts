//
//  CatFactsTestsAPI.swift
//  CatFactsTests
//
//  Created by sanad barjawi on 26/01/2022.
//

import XCTest
@testable import CatFacts

class CatFactsTestsAPI: XCTestCase {
    
    private var factsListPresenter: FactsListPresenter?
    private var fetchCatFactsAPIExpectation: XCTestExpectation?
    private var factsAPI: ListServices?
    
    override func setUp() {
        /// setting up needed variables for the tests
        factsAPI = ListServices()
        factsListPresenter = FactsListPresenter(service: factsAPI!)
        
        //attaching the view to receive call backs from the API
        factsListPresenter?.attachView(self)
    }
    
    func testFetchingFacts() {
        // Create an expectation for a task.
        fetchCatFactsAPIExpectation = expectation(description: "Feching Cat Facts API")
        factsListPresenter?.fetchCatFacts()
        wait(for: [fetchCatFactsAPIExpectation!], timeout: 10)
    }
    
    override func tearDown() {
        ///reseting needed variables
        factsAPI = nil
        //detaching the view
        factsListPresenter?.detachView()
        factsListPresenter = nil
    }

}
extension CatFactsTestsAPI: FactListViewable {
    func reloadData() {}
    
    func didSucceed() {
        XCTAssertNotNil(factsListPresenter?.getCatFacts())
        fetchCatFactsAPIExpectation?.fulfill()
    }
    
    func didFail(with error: Error) {
        XCTAssertNotNil(error)
        fetchCatFactsAPIExpectation?.fulfill()
    }
    
}
