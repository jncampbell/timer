//
//  TimerViewController.swift
//  Timer
//
//  Created by J. Campbell on 10/25/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Cocoa
import Quartz

@IBDesignable
class TimerViewController: NSViewController
{
    var timer = [Timer]()
    var stopWatch = NSTimer()
    var hours = 00;
    var minutes = 00;
    var seconds = 00;
    var numberOfBreaks = 0;
    
  
    @IBOutlet weak var timerTextField: NSTextFieldCell!
    
    @IBAction func pressStart(sender: NSButton) {
        if (!stopWatch.valid) {
            timerTextField.stringValue = formatTime()
            stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  "updateTimeLabel", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pressPause(sender: NSButton) {
        stopWatch.invalidate()
        numberOfBreaks++
    }
    
    @IBAction func pressEnd(sender: NSButton) {
        
        stopWatch.invalidate()
        
        //Create Daily Report
        if let time = Timer(hours: hours, minutes: minutes, seconds: seconds) {
            timer.append(time)
        }
        saveTime()
        resetTime()
        timerTextField.stringValue = formatTime()
    }
    
    func resetTime() -> Void {
        hours = 00;
        minutes = 00;
        seconds = 00;
    }
    
    func updateTimeLabel() -> Void {
        
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
        
        timerTextField.stringValue = formatTime()
    }
    
    private func formatTime() -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        return formatter.stringFromNumber(hours)! + ":" + formatter.stringFromNumber(minutes)! + ":" + formatter.stringFromNumber(seconds)!
    }
    
    func saveTime() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(timer, toFile: Timer.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("failed to save time tracker...")
        }
    }
    
    func loadTime() -> [Timer]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Timer.ArchiveURL.path!) as? [Timer]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColorCreateGenericRGB(51.0/255.0, 45.0/255.0, 65.0/255.0, 1.0)
        if let time = loadTime() {
            timer += time
            for item in timer {
                print(item.description)
            }
        }
    }

}
