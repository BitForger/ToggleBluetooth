//
//  AppDelegate.swift
//  ToggleBluetooth
//
//  Created by Noah Kovacs on 6/8/19.
//  Copyright © 2019 Noah Kovacs. All rights reserved.
//

import Cocoa
import CoreBluetooth
import IOBluetooth

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        statusItem = NSStatusBar.system.statusItem(withLength: -1)
        
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

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBOutlet weak var appMenu: NSMenu!

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
        
        NSMenu.popUpContextMenu(appMenu, with: event, for: button)
    }
    
    @IBAction func toggleBluetooth(_ sender: Any) {
        print("toggle clicked")
        IOBluetoothPreferenceSetControllerPowerState(0)
        IOBluetoothPreferenceSetControllerPowerState(1)
    }
}

