//
//  Report.swift
//  Timer
//
//  Created by J. Campbell on 10/28/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class Report: NSObject {
    
    //MARK: Properties
    var date: Int
    var totalSecondsSpentWorking: Int
    var totalNumberOfBreaks: Int
    var totalSecondsSpentOnBreak: Int
    
    //MARK: Initialization
    init(date: Int, totalSecondsSpentWorking: Int, totalNumberOfBreaks: Int, totalSecondsSpentOnBreak: Int) {
        self.date = date
        self.totalSecondsSpentWorking = totalSecondsSpentWorking
        self.totalNumberOfBreaks = totalNumberOfBreaks
        self.totalSecondsSpentOnBreak = totalSecondsSpentOnBreak
        
        super.init()

    }
}
