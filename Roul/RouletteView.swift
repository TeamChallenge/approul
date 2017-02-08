//
//  RouletteView.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class RouletteView: UIView {
    
    var jogadores : [Jogador]? {
        didSet{
            if let js = self.jogadores?.count {
                self.numberItems = js
            }
            self.setNeedsDisplay()
        }
    }
    
    private var numberItems: Int = 2
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ 
            if self.isFocused {
                self.layer.borderColor = UIColor.red.cgColor
                self.layer.borderWidth = 10
            } else {
                self.layer.borderColor = UIColor.white.cgColor
                self.layer.borderWidth = 0
            }
        }, completion: nil)
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    let viewCenter : UIView = {
        let v = UIView()
        v.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    var elementos: [CircleView] = []
    
    lazy var angle : CGFloat = {
        return CGFloat(2 * M_PI / Double(self.numberItems + 1))
    }()

    private var angleStart : CGFloat!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(#function)
        self.angleStart = self.angle
        self.layer.cornerRadius = min(rect.width, rect.height) / 2
        self.backgroundColor = .green
        self.layer.masksToBounds = true
        let intervalo = (0...numberItems)
        
        let centerView = self.convert(self.center, from: self.superview)
        
        for i in intervalo {
            let circle = CircleView(frame: rect)
            circle.startAngle = CGFloat(angle * CGFloat(i))
            circle.endAngle = CGFloat(angle * CGFloat(i + 1))
            circle.backgroundColor = .clear
            circle.color = i % 2 == 0 ? UIColor.red : UIColor.black
            circle.element = i
//            circle.iconImage = avatars[i % self.avatars.count]
            circle.iconImage = self.jogadores?[i % self.numberItems].imagem
//            self.elementos.append(circle)
            self.addSubview(circle)
            
            let numberLabel = UILabel()
            numberLabel.text = "\(i)"
            numberLabel.font = UIFont.boldSystemFont(ofSize: 50)
            numberLabel.textColor = UIColor.white
            numberLabel.backgroundColor = .clear
            numberLabel.sizeToFit()
            let th = angle * (CGFloat(i) + 0.5)
            numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th - CGFloat(M_PI * 0.5)))
            numberLabel.center = CGPoint(x: centerView.x + 205 * CGFloat(cos(th)), y: centerView.y + 205 * CGFloat(sin(th)))
            //            numberLabel.center = self.center
            self.addSubview(numberLabel)
        }
        
        viewCenter.translatesAutoresizingMaskIntoConstraints = false
        viewCenter.backgroundColor = .brown
        viewCenter.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) + self.angle * 0.5)
        self.addSubview(viewCenter)
        
        viewCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewCenter.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewCenter.heightAnchor.constraint(equalToConstant: rect.height * 0.4).isActive = true
        viewCenter.widthAnchor.constraint(equalToConstant: rect.width * 0.05).isActive = true
        viewCenter.layer.cornerRadius = (rect.height * 0.2) / 2
        
        print(self.jogadores)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    enum ModeRand {
        case time
        case angle
    }
    
    func rand(mode: ModeRand = .angle) -> Int {
        var randon: Int
        switch mode {
        case .time:
//            randon = CGFloat(Double.random(min: 1, max: 2))
            randon = randomInt(min: 1, max: 2)
            break
        case .angle:
//            randon = CGFloat(Double.random(min: 2, max: 12))
            randon = randomInt(min: self.numberItems, max: 100)
            break
        }
        return randon
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    var endAngle: Int = 0
    
    func girar(withIntensidade intensidade: Int, _ completion: @escaping (_ jogador: Jogador?) -> Void) {
        let currentAngle = self.viewCenter.layer.presentation()?.value(forKeyPath: "transform.rotation") as! Double
//        print("currentAngle: ", currentAngle)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = currentAngle
//        let valorRand = rand()
        let valorRand = intensidade / 10
        let by = CGFloat(valorRand) * self.angle
        self.endAngle += valorRand
        let duration = rand(mode: .time)
        animation.byValue = by
        animation.duration = CFTimeInterval(duration)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        let id = Int(self.endAngle) % (self.numberItems + 1)
//        print(id, valorRand)
        
        delay(duration) {
//            let dic = ["id" : id, "imagem": [ava]]
            self.jogadores?[id].id = "\(id)"
            completion(self.jogadores?[id])
        }
        
        self.viewCenter.layer.add(animation, forKey: "Animation")
    }
    
}
