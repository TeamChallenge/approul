//
//  RouletteView.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class RouletteView: UIView {
    
    var numberItems: Int = 2 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    let viewCenter : UIView = {
        let v = UIView()
        v.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var elementos: [CircleView] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(#function)
        self.layer.cornerRadius = min(rect.width, rect.height) / 2
        self.backgroundColor = .green
        self.layer.masksToBounds = true
        let intervalo = (0...numberItems)
        
        let centerView = self.convert(self.center, from: self.superview)
        let angle = 2 * M_PI / Double(intervalo.count)
        
        for i in intervalo {
            let circle = CircleView(frame: rect)
            circle.startAngle = CGFloat(angle * Double(i))
            circle.endAngle = CGFloat(angle * Double(i + 1))
            circle.backgroundColor = .clear
            circle.color = i % 2 == 0 ? UIColor.red : UIColor.black
            circle.element = i
            self.elementos.append(circle)
            self.addSubview(circle)
            
            let numberLabel = UILabel()
            numberLabel.text = "\(i)"
            numberLabel.font = UIFont.boldSystemFont(ofSize: 50)
            numberLabel.textColor = UIColor.white
            numberLabel.backgroundColor = .clear
            numberLabel.sizeToFit()
            let th = angle * (Double(i) + 0.5)
            numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th - M_PI * 0.5))
            numberLabel.center = CGPoint(x: centerView.x + 205 * CGFloat(cos(th)), y: centerView.y + 205 * CGFloat(sin(th)))
            //            numberLabel.center = self.center
            self.addSubview(numberLabel)
        }
        
        viewCenter.translatesAutoresizingMaskIntoConstraints = false
        viewCenter.backgroundColor = .brown
        viewCenter.transform = CGAffineTransform(rotationAngle: CGFloat(2 * angle))
        self.addSubview(viewCenter)
        
        viewCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewCenter.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewCenter.heightAnchor.constraint(equalToConstant: rect.height * 0.4).isActive = true
        viewCenter.widthAnchor.constraint(equalToConstant: rect.width * 0.05).isActive = true
        viewCenter.layer.cornerRadius = (rect.height * 0.2) / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    enum ModeRand {
        case time
        case angle
    }
    
    func rand(mode: ModeRand = .angle) -> Double {
        var randon: Double
        switch mode {
        case .time:
            randon = Double.random(min: 1, max: 2)
            break
        case .angle:
            randon = Double.random(min: 2, max: 12)
            break
        }
        print(randon)
        return randon
    }
    
    func girar() {
        let currentAngle = self.viewCenter.layer.presentation()?.value(forKeyPath: "transform.rotation") as? Double
        print("currentAngle: ", currentAngle)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = currentAngle
        let by = rand() * M_PI
        let duration = rand(mode: .time)
        animation.byValue = by
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        print("by: \(by), duration: \(duration)")
        let result = (duration * by)
        print(result)
        
        
        let v = Int(result) % self.elementos.count
        print(self.elementos[v].element)
        
        
        self.viewCenter.layer.add(animation, forKey: "Animation")
    }
    
}
