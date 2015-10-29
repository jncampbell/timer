//
//  Report.swift
//  Timer
//
//  Created by J. Campbell on 10/28/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class Report: NSObject, NSCoding {
    
    //MARK: Properties
    var date: Int
    var totalSecondsSpentWorking: Int
    var totalNumberOfBreaks: Int
    var totalSecondsSpentOnBreak: Int
    
    //MARK: Archiving Paths
    static let DocumentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentDirectory.URLByAppendingPathComponent("productivity-reports")
    
    //MARK: Initialization
    init(date: Int, totalSecondsSpentWorking: Int, totalNumberOfBreaks: Int, totalSecondsSpentOnBreak: Int) {
        self.date = date
        self.totalSecondsSpentWorking = totalSecondsSpentWorking
        self.totalNumberOfBreaks = totalNumberOfBreaks
        self.totalSecondsSpentOnBreak = totalSecondsSpentOnBreak
        
        super.init()
    }
    
    struct PropertyName {
        static let dateKey = "date"
        static let timeSpentWorkingKey = "timeSpentWorking"
        static let numberOfBreaksKey = "numberOfBreaks"
        static let timeSpentOnBreakKey = "timeSpentOnBreak"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: PropertyName.dateKey)
        aCoder.encodeObject(totalSecondsSpentWorking, forKey: PropertyName.timeSpentWorkingKey)
        aCoder.encodeObject(totalNumberOfBreaks, forKey: PropertyName.numberOfBreaksKey)
        aCoder.encodeObject(totalSecondsSpentOnBreak, forKey: PropertyName.timeSpentOnBreakKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObjectForKey(PropertyName.dateKey) as! Int
        let totalSecondsSpentWorking = aDecoder.decodeObjectForKey(PropertyName.timeSpentWorkingKey) as! Int
        let totalNumberOfBreaks = aDecoder.decodeObjectForKey(PropertyName.numberOfBreaksKey) as! Int
        let totalSecondsSpentOnBreak = aDecoder.decodeObjectForKey(PropertyName.timeSpentOnBreakKey) as! Int
        
        self.init(date: date, totalSecondsSpentWorking: totalSecondsSpentWorking, totalNumberOfBreaks: totalNumberOfBreaks, totalSecondsSpentOnBreak: totalSecondsSpentOnBreak)
    }
}
