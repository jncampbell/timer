//
//  Timer.swift
//  Timer
//
//  Created by J. Campbell on 10/27/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Foundation

class Timer: NSObject {
    
    //MARK: Properties
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    //MARK: Initialization
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        
        super.init()
    }
    
    func reset() -> String {
        hours = 00
        minutes = 00
        seconds = 00
        return returnAsString()
    }
    
    func returnAsString() -> String {

        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter.stringFromNumber(hours)! + ":" + formatter.stringFromNumber(minutes)! + ":" + formatter.stringFromNumber(seconds)!
    }
    
    func increment() {
        if (minutes == 59 && seconds == 59) {
            hours += 1
            minutes = 00
            seconds = 00
        } else if (seconds == 59) {
            minutes += 1
            seconds = 00
        } else {
            seconds += 1
        }
    }
    
}


