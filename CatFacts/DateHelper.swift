//
//  DateHelper.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import Foundation

public struct DateHelper {
    
    /// checks whether the given timeInterval is less than 90days or past it.
    /// - Parameter timeInterval: timeInterval
    /// - Returns: true if less, false if past the 90 days
    public static func isSpanIsLessThan90Days(timeInterval: TimeInterval,
                                        currentDate: Date) -> Bool {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: timeInterval)
        let startOfNow = calendar.startOfDay(for: currentDate)
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        return abs(day) <= 90
    }
}
