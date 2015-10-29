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
    
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
//        if let times = loadTime() {
//            switch tableColumn!.identifier {
//                case "DateColumn":
//                    return nil
//                case "TimeWorkedColumn":
//                    let time = String(times[row].hours) + ":" + String(times[row].minutes) + ":" + String(times[row].seconds)
//                    return time
//                case "NumberOfStopsColumn":
//                    return nil
//                case "TimeStoppedColumn":
//                    return nil
//            default: break
//            }
//        }
        return nil
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
    }
    
}
