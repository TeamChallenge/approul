//
//  TimerView.swift
//  Roul
//
//  Created by Thiago Vinhote on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit
import CoreGraphics

class TimerView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        let arcStartAngle = M_PI;
        let arcEndAngle = 2 * M_PI;
        
//        let startPoint = CGPointMake(...);
//        let endPoint = CGPointMake(...);
        
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        
        let colors: [CGFloat] =
            [
                1.0, 0.0, 0.0, 1.0,   //RGBA values (so red to green in this case)
                0.0, 1.0, 0.0, 1.0
        ];
        
//        let gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
        let g = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2)
        //Where the 2 is for the number of color components. You can have more colors throughout //your gradient by adding to the colors[] array, and changing the components value.
        
//        CGColorSpaceRelease(colorSpace);
        
        //Now for the arc part...
        
        let arc = CGMutablePath()
        
        arc.move(to: <#T##CGPoint#>, transform: <#T##CGAffineTransform#>)
        CGPathMoveToPoint(arc, NULL, startPoint.x, startPoint.y);
        
        
        //Here, the CGPoint self.arcCenter is the point around which the arc is placed, so maybe the
        //middle of your view. self.radius is the distance between this center point and the arc.
        CGPathAddArc(arc, NULL, self.arcCenter.x, self.arcCenter.y, self.radius,
                     arcStartAngle, arcEndAngle, YES);
        
        
        //This essentially draws along the path in an arc shape
        CGPathRef strokedArc = CGPathCreateCopyByStrokingPath(arc, NULL, 5.0f,
                                                              kCGLineCapButt, kCGLineJoinMiter, 10);
        
        
        CGContextSaveGState(context);
        
        CGContextAddPath(context, strokedArc);
        CGContextClip(context);
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        
        CGContextDrawPath(context, kCGPathFillStroke);
        
        CGGradientRelease(gradient);
        CGContextRestoreGState(context);
    }

}
