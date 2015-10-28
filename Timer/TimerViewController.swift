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
    var listOfTimes = [Timer]()
    var stopWatch = NSTimer()
    var hours = 00;
    var minutes = 00;
    var seconds = 00;
    var report = Report()
    @IBOutlet weak var timerTextField: NSTextFieldCell!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var pauseButton: NSButton!
    @IBOutlet weak var endButton: NSButton!
    
    @IBAction func pressStart(sender: NSButton) {
        setStateForButtons(sender)
        report.date = NSDate.timeIntervalSinceReferenceDate()
        report.timeStarted = NSDate.timeIntervalSinceReferenceDate()
        timerTextField.stringValue = formatTime()
        stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  "updateTimeLabel", userInfo: nil, repeats: true)
        sender.enabled = false
    }
    
    @IBAction func pressPause(sender: NSButton) {
        setStateForButtons(sender)
        if (sender.state == 1) {
            stopWatch.invalidate()
            report.numberOfBreaks++
        } else {
            stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pressEnd(sender: NSButton) {
        setStateForButtons(sender)
        stopWatch.invalidate()
        report.timeStopped = NSDate.timeIntervalSinceReferenceDate()

        //Create Daily Report
        if let time = Timer(hours: hours, minutes: minutes, seconds: seconds) {
            listOfTimes.append(time)
        }
        saveTime()
        resetTime()
        timerTextField.stringValue = formatTime()
    }
    
    private struct ButtonNames {
        static let Start = "Start"
        static let Pause = "Pause"
        static let Resume = "Resume"
        static let End = "End"
    }
    
    func setStateForButtons(buttonPressed: NSButton?=nil) -> Void {
        
        if let button = buttonPressed {
            switch button.title {
            case ButtonNames.Start:
                startButton.enabled = false
                pauseButton.enabled = true
                endButton.enabled = true
            case ButtonNames.End:
                startButton.enabled = true
                pauseButton.enabled = false
                if pauseButton.state == 1 {
                    pauseButton.title = ButtonNames.Pause
                    pauseButton.state = 0
                }
                endButton.enabled = false
            case ButtonNames.Pause:
                if button.state == 1 {
                    button.title = ButtonNames.Resume
                }
            case ButtonNames.Resume:
                if button.state == 0 {
                    button.title = ButtonNames.Pause
                }
            default: break
            }
        } else {
            startButton.enabled = true
            pauseButton.enabled = false
            endButton.enabled = false
        }
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
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(listOfTimes, toFile: Timer.ArchiveURL.path!)
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
        setStateForButtons()
        if let time = loadTime() {
            listOfTimes += time
        }
    }

}
