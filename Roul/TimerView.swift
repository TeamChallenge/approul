//
//  TimerView.swift
//  Roul
//
//  Created by Thiago Vinhote on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    fileprivate var startAngle: CGFloat = (3.0 * CGFloat(M_PI))/2
    fileprivate var endAngle: CGFloat = (3.0 * CGFloat(M_PI))/2 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var numberSections: Int = 30{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    private var numberCount: CGFloat = 0
    private var numberRepeats: Int = 0;
    
    var duration: CGFloat = 0
    
    typealias handlerCompletion = () -> Void
    
    private var completion: handlerCompletion?
    
    private lazy var angle: CGFloat = {
        return (2 * CGFloat(M_PI)) / (CGFloat(self.numberSections) * self.duration * 100)
    }()
    
    fileprivate var timer: Timer?

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.clipsToBounds = true
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
    }
    
    func start(withTime time: TimeInterval, completion: @escaping handlerCompletion) {
        let s = time / 100
        self.duration = CGFloat(s)
        self.numberCount = CGFloat(self.numberSections) * self.duration * 100.0
        self.completion = completion
        self.timer = Timer.scheduledTimer(timeInterval: s, target: self, selector: #selector(TimerView.atualizarView), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func atualizarView() {
        self.endAngle += self.angle
        
        if CGFloat(self.numberRepeats) > self.numberCount {
            self.timer?.invalidate()
            self.timer = nil
            
            self.endAngle = (3.0 * CGFloat(M_PI))/2
            self.numberRepeats = 0
            
            print("Terminou")
            self.completion?()
            return
        }
        
        self.numberRepeats += 1

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext() {

            self.backgroundColor = .clear
            UIColor.green.setFill()
            
            let origin = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
            context.move(to: origin)
            context.addArc(center: origin, radius: origin.x, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: false)
            context.drawPath(using: .fill)
        }
    }

}
