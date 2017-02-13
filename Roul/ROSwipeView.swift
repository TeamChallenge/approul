//
//  ROSwipeView.swift
//  Roul
//
//  Created by Thiago Vinhote on 11/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(withColor color: UIColor, _ text: String? = nil) {
        self.init()
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if text != nil {
            let uilabel = UILabel(frame: CGRect.zero)
            uilabel.text = text
            uilabel.translatesAutoresizingMaskIntoConstraints = false
            uilabel.textColor = .black
            uilabel.textAlignment = .center
            
            self.addSubview(uilabel)
            uilabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            uilabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            uilabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            uilabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
    }
    
}

class ROSwipeView: UIView {
    
    fileprivate let containerElements : UIView = {
        return UIView(withColor: .orange)
    }()
    
    fileprivate let elementItem: UIView = {
        return UIView(withColor: .green, "Verdade")
    }()
    
    fileprivate let elementItem2: UIView = {
        return UIView(withColor: .blue, "Desafio")
    }()
    
    fileprivate let elementItem3: UIView = {
        return UIView(withColor: .purple, "?")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        
        self.addSubview(self.containerElements)
        self.containerElements.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        self.containerElements.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.containerElements.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        self.containerElements.widthAnchor.constraint(equalToConstant: 350).isActive = true
     
        self.containerElements.addSubview(self.elementItem)
        self.elementItem.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.elementItem.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.elementItem.centerXAnchor.constraint(equalTo: self.containerElements.centerXAnchor).isActive = true
        self.elementItem.topAnchor.constraint(equalTo: self.containerElements.topAnchor, constant: -60).isActive = true
        
        self.containerElements.addSubview(self.elementItem2)
        self.elementItem2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.elementItem2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.elementItem2.centerXAnchor.constraint(equalTo: self.containerElements.centerXAnchor).isActive = true
        self.elementItem2.topAnchor.constraint(equalTo: self.containerElements.topAnchor, constant: -60).isActive = true
        
        self.containerElements.addSubview(self.elementItem3)
        self.elementItem3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.elementItem3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.elementItem3.centerXAnchor.constraint(equalTo: self.containerElements.centerXAnchor).isActive = true
        self.elementItem3.topAnchor.constraint(equalTo: self.containerElements.topAnchor, constant: -60).isActive = true
        self.containerElements.clipsToBounds = true
        
        self.elementItem.layer.borderColor = UIColor.black.cgColor
        self.elementItem.layer.borderWidth = 1
        self.elementItem.layer.shadowColor = UIColor.black.cgColor
        self.elementItem.layer.shadowOpacity = 0.8
        self.elementItem.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.elementItem.layer.shadowRadius = 3
        
        self.elementItem2.layer.borderColor = UIColor.black.cgColor
        self.elementItem2.layer.borderWidth = 1
        self.elementItem2.layer.shadowColor = UIColor.black.cgColor
        self.elementItem2.layer.shadowOpacity = 0.8
        self.elementItem2.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.elementItem2.layer.shadowRadius = 3
        
        self.elementItem3.layer.borderColor = UIColor.black.cgColor
        self.elementItem3.layer.borderWidth = 1
        self.elementItem3.layer.shadowColor = UIColor.black.cgColor
        self.elementItem3.layer.shadowOpacity = 0.8
        self.elementItem3.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.elementItem3.layer.shadowRadius = 3
    }
    
}

extension ROSwipeView {
    
    func animacao() {
//        let animation = CABasicAnimation(keyPath: "position.y")
//        animation.fromValue = 50
//        animation.toValue = 250
////        animation.repeatCount = Float.infinity
//        animation.duration = 1
//        animation.isRemovedOnCompletion = true
//        self.elementItem.layer.add(animation, forKey: "first")
//        self.elementItem.layer.position = CGPoint(x: self.elementItem.layer.position.x, y: 50)
        
        let zPosition = CABasicAnimation()
        zPosition.keyPath = "zPosition";
        zPosition.fromValue = -1;
        zPosition.toValue = 1;
        zPosition.duration = 1.2;
        
        let rotation = CAKeyframeAnimation()
        rotation.keyPath = "transform.rotation";
        rotation.values = [ 0, 0.14, 0 ];
        rotation.duration = 1.2;
        rotation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)];
        
        let position = CAKeyframeAnimation()
        position.keyPath = "position";
        position.values = [NSValue(cgPoint: CGPoint.zero), NSValue(cgPoint: CGPoint(x: 110, y: -20)), NSValue(cgPoint: CGPoint.zero)]
        position.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        position.isAdditive = true
        position.duration = 1.2;
        
        let group = CAAnimationGroup()
        group.animations = [zPosition, rotation, position]
        group.duration = 1.2;
//        group.beginTime = 0.5;
        
        self.elementItem.layer.add(group, forKey: "shuffle")
        self.elementItem.layer.zPosition = 1
    }
    
    func animacao2() {
        let duration : CFTimeInterval = 2
        let individual = duration / 3
        let scale = CAKeyframeAnimation(keyPath: "transform.scale")
        scale.values = [1, 1.2, 1.4, 1.2, 1]
        scale.duration = duration
        scale.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)];
        
        let position = CAKeyframeAnimation(keyPath: "position.y")
        position.values = [0, 70, 140, 210, 280]
        position.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)];
        position.isAdditive = true
        position.duration = duration
        
        let positionx = CAKeyframeAnimation(keyPath: "position.x")
        positionx.values = [0, 20, 30, 20, 0]
        positionx.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)];
        positionx.isAdditive = true
        positionx.duration = duration
        
        let rotation = CAKeyframeAnimation()
        rotation.keyPath = "transform.rotation";
        rotation.values = [ -0.08, -0.04, 0, 0.04, 0.08];
        rotation.duration = duration
        rotation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)];
        
        let shadow = CAKeyframeAnimation(keyPath: "shadowRadius")
        shadow.values = [3, 6, 12, 6, 3]
        shadow.duration = duration
        shadow.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)];
        
        let group = CAAnimationGroup()
        group.animations = [scale, position, positionx, rotation, shadow]
        group.duration = duration
//        group.fillMode = kCAFillModeForwards
//        group.isRemovedOnCompletion = false
        group.repeatCount = 12
        
        self.elementItem.layer.add(group, forKey: "group")
        
        group.beginTime = CACurrentMediaTime() + individual
        
        self.elementItem2.layer.add(group, forKey: "group")
        
        group.beginTime = CACurrentMediaTime() + individual * 2
        
        self.elementItem3.layer.add(group, forKey: "group")
    }
    
}







