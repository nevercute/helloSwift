//
//  Canvas.swift
//  MyFirstDrawer
//
//  Created by NEVERCUTE on 22/03/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import UIKit

class Canvas: UIView {
    var lines = [[CGPoint]]()
    
    public func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    public func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else
        { return }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil ) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine )
        
        //        var lastLine = lines.last
        //        lastLine?.append(point)
        
        setNeedsDisplay()
        
    }
    
    
}
