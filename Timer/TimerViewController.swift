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
    
    var timer = NSTimer()
    let formatter = NSNumberFormatter()
    var hours = 00;
    var minutes = 00;
    var seconds = 00;
    var numberOfBreaks = 0;
    
    @IBOutlet weak var timerTextField: NSTextFieldCell!
    
    struct PathNames {
        static let ReportPath = "productivity-in-hours.txt"
    }
    
    @IBAction func pressStart(sender: NSButton) {
        if (!timer.valid) {
            timerTextField.stringValue = formatTime()
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  "updateTimeLabel", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pressPause(sender: NSButton) {
        timer.invalidate()
        numberOfBreaks++
    }
    
    @IBAction func pressEnd(sender: NSButton) {
        
        timer.invalidate()
        
        //Create Daily Report
        
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
        formatter.minimumIntegerDigits = 2
        return formatter.stringFromNumber(hours)! + ":" + formatter.stringFromNumber(minutes)! + ":" + formatter.stringFromNumber(seconds)!
    }
    
    func saveDirectory() -> String {
        let saveToDirectory = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true)
        return saveToDirectory[0] as String
    }
    
    func writeToFile() -> Void {
        let savePath = saveDirectory() + "/" + PathNames.ReportPath
        if let outputStream = NSOutputStream(toFileAtPath: savePath, append: true) {
            let output = formatTime()
            outputStream.open()
            outputStream.write(output, maxLength: output.characters.count)
            outputStream.close()
        } else {
            print("Failed to write to file")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = CGColorCreateGenericRGB(51.0/255.0, 45.0/255.0, 65.0/255.0, 1.0)
        writeToFile()
    }

}
