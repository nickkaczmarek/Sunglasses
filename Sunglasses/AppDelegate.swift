//
//  AppDelegate.swift
//  Sunglasses
//
//  Created by Nicholas Kaczmarek on 2024-04-26.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        setUpWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    private func setUpWindow() {
        guard let frame = NSScreen.main?.frame else { fatalError("Could not get the main screen") }

        self.window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        self.window.ignoresMouseEvents = true
        self.window.isOpaque = false
        self.window.level = .floating
        self.window.backgroundColor = NSColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.2)
        self.window.orderFrontRegardless()
    }

}

