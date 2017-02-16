//
//  TimerProgress.swift
//  Roul
//
//  Created by Thiago Vinhote on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class TimerProgress: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    var colorProgress: UIColor = .green {
        didSet{
            self.setup()
        }
    }
    
    typealias handlerCompletion = () -> Void
    
    private var progressCircle = CAShapeLayer()
    
    private func setup() {
        self.progressCircle.removeFromSuperlayer()
        
        let center = CGPoint(x: self.bounds.origin.x + self.frame.width / 4, y: self.bounds.origin.y + self.frame.height / 4)
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: center, size: CGSize(width: self.frame.width * 0.5, height: self.frame.height * 0.5)))
        
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = self.colorProgress.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = self.frame.width / 2
        
        self.layer.addSublayer(progressCircle)
        
        self.transform = CGAffineTransform(rotationAngle: (3*CGFloat(M_PI)/2))
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func startAnimation(withTimer time: TimeInterval, completion: @escaping handlerCompletion) {
        self.progressCircle.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = time
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        progressCircle.add(animation, forKey: "strokeEnd")
        
        delay(Int(time)) { 
            completion()
        }
    }
    
}
