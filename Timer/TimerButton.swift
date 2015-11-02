//
//  TimerButton.swift
//  Timer
//
//  Created by J. Campbell on 11/2/15.
//  Copyright © 2015 James N. Campbell. All rights reserved.
//

import Cocoa

class TimerButton: NSButton {
    
    override var wantsUpdateLayer:Bool {
        return true
    }
    
    override func updateLayer() {
        self.wantsLayer = true
        self.layer!.borderWidth = 1.0
        self.layer!.borderColor = NSColor.blackColor().CGColor
        self.layer!.cornerRadius = 2.5
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        // Drawing code here.
    }
    
}
