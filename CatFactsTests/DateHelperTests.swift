//
//  DateHelperTests.swift
//  CatFactsTests
//
//  Created by sanad barjawi on 26/01/2022.
//

import XCTest
@testable import CatFacts

class DateHelperTests: XCTestCase {
    
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
