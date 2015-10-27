//
//  Timer.swift
//  Timer
//
//  Created by J. Campbell on 10/27/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class Timer: NSObject, NSCoding {
    
    //MARK: Properties
    var hours: Int
    var minutes: Int
    var seconds: Int
    var numberOfStops = 0
    var timeStopped = 0
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("listOfTimes")
    
    //MARK: Types
    struct PropertyKey {
        static let hoursKey = "hours"
        static let minutesKey = "minutes"
        static let secondsKey = "seconds"
    }
    
    //MARK: Initialization
    init?(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        
        super.init()
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(hours, forKey: PropertyKey.hoursKey)
        aCoder.encodeObject(minutes, forKey: PropertyKey.minutesKey)
        aCoder.encodeObject(seconds, forKey: PropertyKey.secondsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let hours = aDecoder.decodeObjectForKey(PropertyKey.hoursKey) as! Int
        let minutes = aDecoder.decodeObjectForKey(PropertyKey.minutesKey) as! Int
        let seconds = aDecoder.decodeObjectForKey(PropertyKey.secondsKey) as! Int
        
        self.init(hours: hours, minutes: minutes, seconds: seconds)
    }
}


