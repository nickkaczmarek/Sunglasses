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
    var tagViewController: TagViewController!
    var currentAlpha: CGFloat = 0.2 {
        didSet {
            self.window.backgroundColor = self.window.backgroundColor.withAlphaComponent(currentAlpha)
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        setUpWindow()
        setUpStatusBar()

        NotificationCenter.default.addObserver(forName: .colorChanged, object: nil, queue: .main) { [weak self] in
            guard let newColor = $0.object as? NSColor, let currentAlpha = self?.currentAlpha else { return }

            self?.window.backgroundColor = newColor.withAlphaComponent(currentAlpha)
        }
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
        self.window.backgroundColor = NSColor(red: 0.0, green: 0.0, blue: 1.0, alpha: currentAlpha)
        self.window.orderFrontRegardless()
    }

    private func setUpStatusBar() {
        let statusBar = NSStatusBar.system

        self.statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        self.statusBarItem.button?.image = NSImage(named: "MenubarIcon")

        let statusBarMenu = NSMenu(title: "Sunglasses Status Bar Menu")
        self.statusBarItem.menu = statusBarMenu

        tagViewController = TagViewController()

        // Get the view from the tag view controller
        let tagView = tagViewController.view
        let colorCount = tagViewController.colors.count
        let padding = tagViewController.padding
        let width = tagViewController.width

        let frameWidth = (colorCount * width) + (padding * 2)
        tagView.frame = NSRect(x: 0, y: 0, width: frameWidth, height: width + 10)

        // Create a menu item and add our tag view
        let tagMenuItem = NSMenuItem()
        tagMenuItem.target = self
        tagMenuItem.view = tagView

        statusBarMenu.addItem(tagMenuItem)

        let sliderFrame = NSRect(x: 0, y: 0, width: frameWidth, height: width)
        let opacitySlider = NSSlider(frame: sliderFrame)
        opacitySlider.minValue = 0.0
        opacitySlider.maxValue = 1.0
        opacitySlider.floatValue = 0.2
        opacitySlider.numberOfTickMarks = 10
        opacitySlider.allowsTickMarkValuesOnly = true
        opacitySlider.target = self
        opacitySlider.action = #selector(sliderValueChanged(_:))

        let opacitySliderMenuItem = NSMenuItem()
        opacitySliderMenuItem.view = opacitySlider
        statusBarMenu.addItem(opacitySliderMenuItem)

        statusBarMenu.addItem(
            NSMenuItem(
                title: "Toggle Sunglasses",
                action: #selector(AppDelegate.toggleSunglasses),
                keyEquivalent: ""
            )
        )

        statusBarMenu.addItem(
            NSMenuItem(
                title: "Quit",
                action: #selector(NSApplication.shared.terminate(_:)),
                keyEquivalent: ""
            )
        )
    }

    @objc func sliderValueChanged(_ sender: NSSlider) {
        currentAlpha = CGFloat(sender.floatValue)
    }

    @objc func toggleSunglasses() {
        NSApplication.shared.isHidden ? NSApplication.shared.unhide(self) : NSApplication.shared.hide(self)
    }

}

