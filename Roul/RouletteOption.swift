//
//  RouletteOption.swift
//  Roul
//
//  Created by Thiago Vinhote on 16/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit


class RouletteOption: UIView {

    class ArcView: UIView {
        
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
    
    var timer: Timer?
    var speedCounter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private lazy var angle : CGFloat = {
        return CGFloat(2 * M_PI / Double(6))
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .clear
    }
    
    fileprivate var arcs: [ArcView] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let centerView = self.convert(self.center, from: self.superview)
        
        for i in 0...5 {
            let arc = ArcView(frame: rect)
            arc.startAngle = CGFloat(angle * CGFloat(i))
            arc.endAngle = CGFloat(angle * CGFloat(i + 1))
            arc.backgroundColor = .clear
            arc.color = (i % 2 == 0) ? UIColor.green : UIColor.green
            arc.layer.opacity = 0.1
            self.arcs.append(arc)
            self.addSubview(arc)
            
            let numberLabel = UILabel()
            numberLabel.text = "Ve"
            numberLabel.font = UIFont.boldSystemFont(ofSize: 50)
            numberLabel.textColor = UIColor.white
            numberLabel.backgroundColor = .clear
            numberLabel.sizeToFit()
            let th = angle * (CGFloat(i) + 0.5)
//            numberLabel.transform = CGAffineTransform(rotationAngle: th)
//            numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th - CGFloat(M_PI * 0.5)))
            numberLabel.center = CGPoint(x: centerView.x + 100 * CGFloat(cos(th)), y: centerView.y + 100 * CGFloat(sin(th)))
            self.addSubview(numberLabel)
        }
    }

}

extension RouletteOption: AnimationProtocol {
    
    func animacaoMove(inicial: CGPoint, final: CGPoint, completion: @escaping handlerCompletion) {
        self.layer.add(animacaoMoveCom(pontoInicial: inicial, eFinal: final), forKey: "position")
        delay(1, finish: {
            completion()
        })
    }
    
}

extension RouletteOption {
    
    func startAnimation(completion: @escaping handlerCompletion) {
//        self.timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(RouletteOption.light), userInfo: nil, repeats: true)
//        self.speedCounter = 500
        let a = CAKeyframeAnimation(keyPath: "opacity")
        a.values = [0.1, 1, 0.1]
        a.duration = 0.6
        a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        a.fillMode = kCAFillModeForwards
//        a.isRemovedOnCompletion = false
        for (i, arc) in self.arcs.enumerated() {
            a.beginTime = CACurrentMediaTime() + Double(i) * 0.3
            arc.layer.add(a, forKey: "a")
        }
        delay(2) { 
            completion()
        }
    }    
}
