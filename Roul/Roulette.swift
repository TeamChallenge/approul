//
//  Roulette.swift
//  Roul
//
//  Created by Thiago Vinhote on 21/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class Roulette: UIView {

    var viewCenter : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.colorFromHex(0x674332)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewMedium : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.colorFromHex(0xFBEBCD, alpha: 0.49)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewBorder : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.colorFromHex(0xFBEBCD, alpha: 0.57)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.viewBorder)
        self.addSubview(self.viewMedium)
        self.addSubview(self.viewCenter)
        self.backgroundColor = .clear
        
        self.createViews(rect: frame)
        self.cornerRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.viewBorder)
        self.addSubview(self.viewMedium)
        self.addSubview(self.viewCenter)
        self.backgroundColor = .clear
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.createViews(rect: rect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius()
    }
    
}

extension Roulette {
    
    fileprivate func cornerRadius() {
        self.viewCenter.layer.cornerRadius = (self.frame.width * 0.4) / 2
        self.viewCenter.clipsToBounds = true
        self.viewCenter.layer.masksToBounds = true
        self.viewBorder.layer.cornerRadius = (self.frame.width) / 2
        self.viewBorder.clipsToBounds = true
        self.viewMedium.layer.cornerRadius = (self.frame.width * 0.6) / 2
        self.viewMedium.clipsToBounds = true
    }
    
    fileprivate func createViews(rect: CGRect) {
        
        self.viewCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewCenter.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewCenter.widthAnchor.constraint(equalToConstant: rect.width * 0.4).isActive = true
        self.viewCenter.heightAnchor.constraint(equalToConstant: rect.width * 0.4).isActive = true
        
        self.viewMedium.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewMedium.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewMedium.widthAnchor.constraint(equalToConstant: rect.width * 0.6).isActive = true
        self.viewMedium.heightAnchor.constraint(equalToConstant: rect.width * 0.6).isActive = true
        
        self.viewBorder.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewBorder.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewBorder.widthAnchor.constraint(equalToConstant: rect.width).isActive = true
        self.viewBorder.heightAnchor.constraint(equalToConstant: rect.width).isActive = true
    }
    
}
