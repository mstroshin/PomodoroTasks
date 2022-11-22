//
//  PomodoroTasksApp.swift
//  PomodoroTasks
//
//  Created by Maksim Troshin on 22/11/2022.
//

import SwiftUI
import AppKit
import Foundation

@main
struct PomodoroTasksApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
