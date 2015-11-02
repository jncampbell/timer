//
//  TimeClock.swift
//  Timer
//
//  Created by J. Campbell on 10/28/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class TimeClock: NSObject {
    
    var date: String?
    var startTime: NSTimeInterval?
    var endTime: NSTimeInterval?
    var numberOfBreaks = 0
    var totalSecondsSpentWorking = 0 {
        didSet {
            let totalSecondsInReportInterval = Int(endTime!) - Int(startTime!)
            totalSecondsSpentOnBreak = totalSecondsInReportInterval - totalSecondsSpentWorking
        }
    }
    var totalSecondsSpentOnBreak = 0
    
    func generateReport() -> Report {
        return Report(date: date!, totalSecondsSpentWorking: totalSecondsSpentWorking, totalNumberOfBreaks: numberOfBreaks, totalSecondsSpentOnBreak: totalSecondsSpentOnBreak)
    }
    
}
