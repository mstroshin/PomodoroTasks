//
//  AppDelegate.swift
//  PomodoroTasks
//
//  Created by Maksim Troshin on 22/11/2022.
//

import Foundation
import AppKit
import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    let statusBar = NSStatusBar()
    let popover = NSPopover()
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.windows.first?.close()
        
        popover.contentViewController = NSHostingController(rootView: MainView(vm: MainViewModel()))
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "person.fill", accessibilityDescription: nil)
            button.action = #selector(didClickStatusBarButton)
            button.target = self
        }
    }
    
    @objc func didClickStatusBarButton() {
        guard let button = statusItem?.button else { return }
        
        if popover.isShown {
            popover.performClose(nil)
        } else {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            
            //Fix popover's wrong position
            if let origin = popover.contentViewController?.view.window?.frame.origin {
                var mutableOrigin = origin
                mutableOrigin.x += 50
                popover.contentViewController?.view.window?.setFrameOrigin(mutableOrigin)
            }
        }
    }
    
}
