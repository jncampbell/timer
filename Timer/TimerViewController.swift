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
    var stopWatch = NSTimer()
    var reports = [Report]()
    var timer = Timer(hours: 00, minutes: 00, seconds: 00)
    var supervisor = Supervisor()
    
    @IBOutlet weak var timerContainer: NSView!
    @IBOutlet weak var buttonContainer: NSView!
    @IBOutlet weak var timerTextField: NSTextFieldCell!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var pauseButton: NSButton!
    @IBOutlet weak var endButton: NSButton!
    
    @IBAction func pressStart(sender: NSButton) {
        setStateForButtons(sender)
        timerTextField.stringValue = timer.returnAsString()
        stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  "updateTimeLabel", userInfo: nil, repeats: true)
        supervisor.startTime = NSDate().timeIntervalSince1970
        supervisor.date = NSDate().timeIntervalSince1970
        sender.enabled = false
        
    }
    
    @IBAction func pressPause(sender: NSButton) {
        setStateForButtons(sender)
        if (sender.state == 1) {
            stopWatch.invalidate()
            supervisor.numberOfBreaks++
        } else {
            stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pressEnd(sender: NSButton) {
        setStateForButtons(sender)
        stopWatch.invalidate()
        supervisor.endTime = NSDate().timeIntervalSince1970
        supervisor.totalSecondsSpentWorking = (timer.hours * 60 * 60) + (timer.minutes * 60) + timer.seconds
        if reports.last != nil && supervisor.date!.landsOnSameDayAs(NSTimeInterval(reports.last!.date)) {
            reports.last!.totalSecondsSpentWorking += supervisor.totalSecondsSpentWorking
            reports.last!.totalNumberOfBreaks += supervisor.numberOfBreaks
            reports.last!.totalSecondsSpentOnBreak += supervisor.totalSecondsSpentOnBreak
        } else {
            let report = Report(
                date: Int(supervisor.date!),
                totalSecondsSpentWorking: supervisor.totalSecondsSpentWorking,
                totalNumberOfBreaks: supervisor.numberOfBreaks,
                totalSecondsSpentOnBreak: supervisor.totalSecondsSpentOnBreak
            )
            reports.append(report)
        }
        saveReport()
        supervisor.numberOfBreaks = 0
        timerTextField.stringValue = timer.reset()
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
    
    func updateTimeLabel() -> Void {
        timer.increment()
        timerTextField.stringValue = timer.returnAsString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        timerContainer.layer!.contents = NSImage(named: "timer-container-background")
        buttonContainer.layer!.contents = NSImage(named: "button-container-background")
        self.view.layer!.backgroundColor = CGColorCreateGenericRGB(30.0/255.0, 29.0/255.0, 35.0/255.0, 1.0)
        timerTextField.textColor = NSColor(CGColor: CGColorCreateGenericRGB(27.0/255.0, 205.0/255.0, 252.0/255.0, 1.0))
        setStateForButtons()
        if let savedReports = loadReports() {
            reports += savedReports
        }
    }
    
    //MARK: NSCoding
    func saveReport() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(reports, toFile: Report.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed saving reports...")
        }
    }
    
    func loadReports() -> [Report]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Report.ArchiveURL.path!) as? [Report]
    }

}

extension NSTimeInterval {
    
    func landsOnSameDayAs(intervalToCompare: NSTimeInterval) -> Bool {
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if formatter.stringFromDate(NSDate(timeIntervalSince1970: self)) == formatter.stringFromDate(NSDate(timeIntervalSince1970: intervalToCompare)) {
            return true
        }
        
        return false
    }
}




















