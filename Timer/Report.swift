//
//  Report.swift
//  Timer
//
//  Created by J. Campbell on 10/28/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class Report {
    
    var date: NSTimeInterval?
    var timeStarted: NSTimeInterval?
    var timeStopped: NSTimeInterval?
    var numberOfBreaks = 0
    var totalSecondsSpentOnBreak = 0
    
    func generate() -> NSDictionary {
        let report = [
            "date": Int(date!),
            "timeStarted": Int(timeStarted!),
            "timeStopped": Int(timeStopped!),
            "numberOfBreaks": numberOfBreaks,
            "totalSecondsSpentOnBreak": totalSecondsSpentOnBreak
        ]
        return report
    }
    
    
}
