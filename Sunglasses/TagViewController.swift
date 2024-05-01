//
//  TagViewController.swift
//  FinderTagCircles
//
//  Created by Nicholas Kaczmarek on 4/28/24.
//  https://kitcross.net/finder-context-menu-tags/
//

import Cocoa

extension Notification.Name {
    static var colorChanged = Notification.Name("colorChanged")
}

class TagViewController: NSViewController {
    let width = 30
    let height = 30
    let padding = 16

    let colors: [NSColor] = [
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemYellow,
        .systemOrange,
        .systemPurple,
        .systemPink,
        .black
    ]

    override func loadView() {
        view = NSView()
    }

    @objc func tagClicked(_ sender: AnyObject?) {
        guard let tag = sender as? TagControl else { return }
        print("Tag index clicked: \(tag.tag)")
        tag.isSelected.toggle()
        view.subviews
            .map { $0 as! TagControl }
            .filter { $0.tag != tag.tag }
            .forEach { $0.isSelected = false }

        NotificationCenter.default.post(name: .colorChanged, object: tag.color)
    }

    override func viewDidLoad() {
        for color in colors {
            guard let index = colors.firstIndex(of: color) else { fatalError("Could not get index of colors") }

            // offset by padding for first item
            let xPos: Int = index == 0 ? padding : (index * width) + padding
            let frame = NSRect(x: xPos, y: 0, width: width, height: height)
            let tag = TagControl(color, frame: frame)

            tag.tag = index
            tag.target = self
            tag.action = #selector(tagClicked(_:))

            view.addSubview(tag)
        }
    }

}
