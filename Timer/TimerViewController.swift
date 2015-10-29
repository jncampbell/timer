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
    var timer = Timer(hours: 00, minutes: 00, seconds: 00)
    var supervisor = Supervisor()

    @IBOutlet weak var timerTextField: NSTextFieldCell!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var pauseButton: NSButton!
    @IBOutlet weak var endButton: NSButton!
    
    @IBAction func pressStart(sender: NSButton) {
        setStateForButtons(sender)
        timerTextField.stringValue = timer.returnAsString()
        stopWatch = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:  "updateTimeLabel", userInfo: nil, repeats: true)
        supervisor.startTime = NSDate().timeIntervalSince1970
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
        self.view.layer?.backgroundColor = CGColorCreateGenericRGB(51.0/255.0, 45.0/255.0, 65.0/255.0, 1.0)
        setStateForButtons()
    }

}
