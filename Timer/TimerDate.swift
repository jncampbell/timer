//
//  TimerDate.swift
//  Timer
//
//  Created by J. Campbell on 11/1/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class TimerDate {
    
    let dateFormatter = NSDateFormatter()
    let numFormatter = NSNumberFormatter()
    
    func currentTimeInterval() -> NSTimeInterval {
        return NSDate().timeIntervalSince1970
    }
    
    func convertTimeIntervalToDateString(timeInterval: NSTimeInterval) -> String {
        return timeInterval.dateString()
    }
    
    func convertTotalSecondsToHoursMinsSecs(totalSeconds: Int) -> String {
        numFormatter.minimumIntegerDigits = 2
        var hours = 00, minutes = 00, seconds = 00
        let numberOfSecondsInHour = 3600
        hours = totalSeconds / numberOfSecondsInHour
        minutes = (totalSeconds % numberOfSecondsInHour) / 60
        seconds = (totalSeconds % numberOfSecondsInHour) % 60
        
        return numFormatter.stringFromNumber(hours)! + ":" + numFormatter.stringFromNumber(minutes)! + ":" + numFormatter.stringFromNumber(seconds)!
    }
    
    func datesLandOnSameDay(date1: NSTimeInterval, date2: NSTimeInterval) -> Bool {
        dateFormatter.timeZone = NSTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: date1)) == dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: date2)) {
            return true
        }
        
        return false
    }
    
    
}

extension NSTimeInterval {
    
//    func landsOnSameDayAs(intervalToCompare: NSTimeInterval) -> Bool {
//        let formatter = NSDateFormatter()
//        formatter.timeZone = NSTimeZone()
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        if formatter.stringFromDate(NSDate(timeIntervalSince1970: self)) == formatter.stringFromDate(NSDate(timeIntervalSince1970: intervalToCompare)) {
//            return true
//        }
//        
//        return false
//    }
    
    func dateString() -> String {
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: self))
    }
}
