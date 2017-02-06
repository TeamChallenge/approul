//
//  CircleView.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit


class CircleView: UIView {
    
    var startAngle: CGFloat = 0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    var endAngle: CGFloat = 40 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    var color: UIColor = .yellow {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var element: Int?
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            
            self.backgroundColor = .clear
            self.color.setFill()
            
            let origin = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
            context.move(to: origin)
            context.addArc(center: origin, radius: origin.x, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: false)
            context.drawPath(using: .fill)
        }
        
    }
}
