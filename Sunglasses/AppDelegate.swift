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
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        setUpWindow()

        setUpStatusBar()
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

    private func setUpStatusBar() {
        let statusBar = NSStatusBar.system

        self.statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        self.statusBarItem.button?.image = NSImage(named: "MenubarIcon")

        let statusBarMenu = NSMenu(title: "Sunglasses Status Bar Menu")
        self.statusBarItem.menu = statusBarMenu

        statusBarMenu.addItem(
            NSMenuItem(
                title: "Hide Sunglasses",
                action: #selector(AppDelegate.hideSunglasses),
                keyEquivalent: ""
            )
        )

        statusBarMenu.addItem(
            NSMenuItem(
                title: "Show Sunglasses",
                action: #selector(AppDelegate.showSunglasses),
                keyEquivalent: ""
            )
        )
    }

    @objc func hideSunglasses() {
        NSApplication.shared.hide(self)
    }

    @objc func showSunglasses() {
        NSApplication.shared.unhide(self)
    }

}

