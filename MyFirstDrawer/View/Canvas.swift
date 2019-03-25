//
//  Canvas.swift
//  MyFirstDrawer
//
//  Created by NEVERCUTE on 22/03/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import UIKit

class Canvas: UIView {
    var lines = [Line]()
    
    fileprivate var strokeColor: UIColor = UIColor.black
    
    fileprivate var strokeWidth: Float = 1
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setSliderWidth(strokeWidth: Float){
        self.strokeWidth = strokeWidth
    }
    
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

        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.butt)
            for(i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil ) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine )
        
        //        var lastLine = lines.last
        //        lastLine?.append(point)
        
        setNeedsDisplay()
        
    }
    
    
}
