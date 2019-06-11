//
//  ApplicationController.swift
//  ToggleBluetooth
//
//  Created by Noah Kovacs on 6/10/19.
//  Copyright © 2019 Noah Kovacs. All rights reserved.
//

import Foundation
import Cocoa
import IOBluetooth

final class ApplicationController: NSObject {
    
    @IBOutlet weak var applicationMenu: NSMenu!
    
    private var statusItem: NSStatusItem?
    
    override init() {
        super.init()
        
       self.buildMenu()
    }
    
    func buildMenu() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        guard let button = statusItem?.button else {
            print("status bar item failed. try removing some menu bar items")
            NSApp.terminate(nil)
            return
        }
        
        let buttonImage =  NSImage(named: "bluetoothDisabled")
        buttonImage?.isTemplate = true
        
        button.image = buttonImage
        button.target = self
        button.action = #selector(displayMenu)
    }
    
    @IBAction func toggleBluetooth(_ sender: Any) {
        IOBluetoothPreferenceSetControllerPowerState(0)
        sleep(5)
        IOBluetoothPreferenceSetControllerPowerState(1)
    }
    
    @objc func displayMenu() {
        guard let button = statusItem?.button else {return}
        
        let x = button.frame.origin.x
        let y = button.frame.origin.y - 5
        let location = button.superview!.convert(NSMakePoint(x, y), to: nil)
        let w = button.window!
        let event = NSEvent.mouseEvent(with: .leftMouseUp,
                                       location: location,
                                       modifierFlags: NSEvent.ModifierFlags(rawValue: 0),
                                       timestamp: 0,
                                       windowNumber: w.windowNumber,
                                       context: w.graphicsContext,
                                       eventNumber: 0,
                                       clickCount: 1,
                                       pressure: 0)!
        
//        NSMenu.popUpContextMenu(applicationMenu, with: event, for: button)
        statusItem?.menu = applicationMenu
    }
    
}
