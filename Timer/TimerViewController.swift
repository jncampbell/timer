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
    //MARK: Instance Variables
    var stopWatch = NSTimer()
    var timer = Timer(hours: 00, minutes: 00, seconds: 00)
    var timeClock = TimeClock()
    var reports = [Report]()
    
    //MARK: IBOutlets
    @IBOutlet weak var timerContainer: NSView!
    @IBOutlet weak var timerTextField: NSTextFieldCell!
    @IBOutlet weak var buttonContainer: NSView!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var pauseButton: NSButton!
    @IBOutlet weak var endButton: NSButton!
    
    //MARK: ButtonFunctions
    @IBAction func pressStart(sender: NSButton) {
        setStateForButtons(sender)
        timerTextField.stringValue = timer.returnAsString()
        stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  "updateTimeLabel", userInfo: nil, repeats: true)
        timeClock.startTime = NSDate().timeIntervalSince1970
        timeClock.date = convertTimeIntervalToDateString(NSDate().timeIntervalSince1970)
        sender.enabled = false
    }
    
    @IBAction func pressPause(sender: NSButton) {
        setStateForButtons(sender)
        if (sender.state == 1) {
            stopWatch.invalidate()
            timeClock.numberOfBreaks++
        } else {
            stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
        }
    }
    
    func updateTimeLabel() -> Void {
        timer.increment()
        timerTextField.stringValue = timer.returnAsString()
    }
    
    @IBAction func pressEnd(sender: NSButton) {
        stopWatch.invalidate()
        setStateForButtons(sender)
        timeClock.endTime = NSDate().timeIntervalSince1970
        timeClock.totalSecondsSpentWorking = (timer.hours * 3600) + (timer.minutes * 60) + timer.seconds
        if reports.last != nil && timeClock.date! == reports.last!.date {
            reports.last!.totalSecondsSpentWorking += timeClock.totalSecondsSpentWorking
            reports.last!.totalNumberOfBreaks += timeClock.numberOfBreaks
            reports.last!.totalSecondsSpentOnBreak += timeClock.totalSecondsSpentOnBreak
        } else {
            let report = timeClock.generateReport()
            reports.append(report)
        }
        saveReport()
        timeClock.numberOfBreaks = 0
        timerTextField.stringValue = timer.reset()
    }
    
    private struct ButtonNames {
        static let Start = "Start"
        static let Pause = "Pause"
        static let Resume = "Resume"
        static let End = "End"
    }
    
    private func setStateForButtons(buttonPressed: NSButton?=nil) -> Void {
        
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
    
    private func convertTimeIntervalToDateString(date: NSTimeInterval) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: date))
    }
    
    //MARK: ViewDesign
    func designView() -> Void {
        self.view.wantsLayer = true
        //Backgrounds
        timerContainer.layer!.contents = NSImage(named: "timer-container-background")
        buttonContainer.layer!.contents = NSImage(named: "button-container-background")
        self.view.layer!.backgroundColor = CGColorCreateGenericRGB(30.0/255.0, 29.0/255.0, 35.0/255.0, 1.0)
        
        //Text Color
        timerTextField.textColor = NSColor(CGColor: CGColorCreateGenericRGB(27.0/255.0, 205.0/255.0, 252.0/255.0, 1.0))

        //Borders
        let borderBottom = CALayer()
        borderBottom.backgroundColor = CGColorCreateGenericRGB(74.0/255.0, 74.0/255.0, 74.0/255.0, 0.25)
        borderBottom.frame = CGRectMake(0.0, 0.0, timerContainer.frame.width, 2.0)
        timerContainer.layer!.addSublayer(borderBottom)
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
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        designView()
        setStateForButtons()
        if let savedReports = loadReports() {
            reports += savedReports
        }
    }

}




















