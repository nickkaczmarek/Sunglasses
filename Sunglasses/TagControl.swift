//
//  TagControl.swift
//  FinderTagCircles
//
//  Created by Nicholas Kaczmarek on 4/28/24.
//  https://kitcross.net/finder-context-menu-tags/
//

import Cocoa

class TagControl: NSButton {
    var isSelected: Bool = false {
        didSet {
            needsDisplay = true
        }
    }
    var color: NSColor

    var mouseInside: Bool = false {
        didSet {
            needsDisplay = true
        }
    }

    init(_ color: NSColor, frame: NSRect) {
        self.color = color
        super.init(frame: frame)

        if trackingAreas.isEmpty {
            let trackingArea = NSTrackingArea(
                rect: frame,
                options: [
                    .activeInKeyWindow,
                    .mouseEnteredAndExited,
                    .inVisibleRect
                ],
                owner: self,
                userInfo: nil)
            addTrackingArea(trackingArea)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseDown(with event: NSEvent) {
        // bubble action up to TagViewController
        if let action = action {
            NSApp.sendAction(action, to: target, from: self)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        color.set()

        let circleRect: NSRect

        if mouseInside {
            circleRect = bounds
        } else {
            circleRect = NSInsetRect(bounds, 3, 3)
        }

        let circle = NSBezierPath(ovalIn: circleRect)
        circle.fill()

        let strokeColor: NSColor = .white
        let insetRect = NSInsetRect(circleRect, 1.0, 1.0)
        let insetCircle = NSBezierPath(ovalIn: insetRect)

        strokeColor.set()
        insetCircle.stroke()

        if isSelected {
            let iconRect = NSInsetRect(bounds, 11, 11)
            let iconPath = removePath(iconRect)

            NSColor.white.setFill()
            iconPath.fill()
            return
        }
    }

    func removePath(_ rect: NSRect) -> NSBezierPath {
      let minX = NSMinX(rect)
      let minY = NSMinY(rect)

      let path = NSBezierPath()
      path.move(to: NSPoint(x: minX, y: minY + 1))
      path.line(to: NSPoint(x: minX + 1, y: minY))
      path.line(to: NSPoint(x: minX + 4, y: minY + 3))
      path.line(to: NSPoint(x: minX + 7, y: minY))
      path.line(to: NSPoint(x: minX + 8, y: minY + 1))
      path.line(to: NSPoint(x: minX + 5, y: minY + 4))
      path.line(to: NSPoint(x: minX + 8, y: minY + 7))
      path.line(to: NSPoint(x: minX + 7, y: minY + 8))
      path.line(to: NSPoint(x: minX + 4, y: minY + 5))
      path.line(to: NSPoint(x: minX + 1, y: minY + 8))
      path.line(to: NSPoint(x: minX, y: minY + 7))
      path.line(to: NSPoint(x: minX + 3, y: minY + 4))
      path.close()
      return path
    }

}
