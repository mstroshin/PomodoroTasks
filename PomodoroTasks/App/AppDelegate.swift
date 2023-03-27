import Foundation
import AppKit
import SwiftUI
import ComposableArchitecture
import SwiftDate

class AppDelegate: NSObject, NSApplicationDelegate {
    let statusBar = NSStatusBar()
    let popover = NSPopover()
    var statusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
//        NSApplication.shared.windows.first?.close()

//        let days = IdentifiedArrayOf(uniqueElements: Date.weekDates.map { DayFeature.State(date: $0) })
//        let currentDayIndex = Date().weekday - Calendar.autoupdatingCurrent.firstWeekday
//        let selectedDay = days[currentDayIndex]
//
//        let mainView = MainView(
//            store: StoreOf<MainFeature>(
//                initialState: .init(
//                    days: days,
//                    selectedDay: selectedDay
//                ),
//                reducer: MainFeature()._printChanges()
//            )
//        )
//        popover.contentViewController = NSHostingController(rootView: mainView)
//        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
//
//        if let button = statusItem?.button {
//            button.image = NSImage(systemSymbolName: "person.fill", accessibilityDescription: nil)
//            button.action = #selector(didClickStatusBarButton)
//            button.target = self
//        }
    }

    @objc private func didClickStatusBarButton() {
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

