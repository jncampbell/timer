//
//  ReportViewController.swift
//  listOfTimes
//
//  Created by J. Campbell on 10/26/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Cocoa

class ReportViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    
    @IBOutlet weak var reportHeader: NSView!
    @IBOutlet weak var tableView: NSTableView!
    var reports = [Report]()
    
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return reports.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {

            switch tableColumn!.identifier {
            case "DateColumn":

                //print(NSDate(timeIntervalSince1970: NSTimeInterval(reports[row].date)))
                return formatDateForTable(reports[row].date)
            case "TimeWorkedColumn":
                return convertSecondsToTime(reports[row].totalSecondsSpentWorking)
            case "NumberOfStopsColumn":
                return reports[row].totalNumberOfBreaks
            case "TimeStoppedColumn":
                return convertSecondsToTime(reports[row].totalSecondsSpentOnBreak)
            default:break
            }
        return nil
    }

    private func formatDateForTable(date: Int) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone()
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: NSTimeInterval(date)))
    }
    
    private func convertSecondsToTime(totalSeconds: Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        var hours = 00, minutes = 00, seconds = 00
        let numberOfSecondsInHour = 3600
        hours = totalSeconds / numberOfSecondsInHour
        minutes = (totalSeconds % numberOfSecondsInHour) / 60
        seconds = (totalSeconds % numberOfSecondsInHour) % 60
        
        return formatter.stringFromNumber(hours)! + ":" + formatter.stringFromNumber(minutes)! + ":" + formatter.stringFromNumber(seconds)!
    }

    
    func setUpHeader() -> Void {
        reportHeader.wantsLayer = true
        let borderBottom = CALayer()
        let borderBottomBounds = CGRect(x: reportHeader.bounds.origin.x, y: reportHeader.bounds.origin.y, width: reportHeader.bounds.width, height: 1.0)
        borderBottom.frame = borderBottomBounds
        borderBottom.backgroundColor = CGColorCreateGenericRGB(203.0/255.0, 203.0/255.0, 203.0/255.0, 1.0)
        reportHeader.layer!.addSublayer(borderBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setUpHeader()
        if let savedReports = loadReports() {
            reports += savedReports
        }
    }
    
    func loadReports() -> [Report]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Report.ArchiveURL.path!) as? [Report]
    }
    
}
