//
//  Roulette.swift
//  Roul
//
//  Created by Thiago Vinhote on 21/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
//        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
        UIColor.colorFromHex(0x674332).setFill()
        context.fillPath()
    }
}

extension UIView {
    
    func shadowButton() {
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 8)
        self.layer.shadowOpacity = 0.6
    }
    
    func shadowRoulette() {
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.6
    }
    
    func shadowRemove() {
        self.layer.shadowRadius = 0
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0
    }
    
    func shadowText() {
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.6
    }
    
}

class Roulette: UIView {

    var viewCenter : UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        
        var triangulo: TriangleView = {
            let t = TriangleView()
            t.translatesAutoresizingMaskIntoConstraints = false
            t.backgroundColor = .clear
            return t
        }()
        
        
        v.addSubview(triangulo)
        triangulo.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        triangulo.centerYAnchor.constraint(equalTo: v.centerYAnchor, constant: -80).isActive = true
        triangulo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        triangulo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
        v.backgroundColor = UIColor.colorFromHex(0xFBEBCD, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.shadowButton()
        return v
    }()
    
    var imageArrow: UIImageView = {
        let i = UIImageView()
        i.image = #imageLiteral(resourceName: "coxinha")
        i.tintColor = .red
        i.contentMode = .scaleAspectFit
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.createViews(rect: rect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius()
    }
    
    var v : UIView = {
        let b = UIView(frame: CGRect.zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.colorFromHex(0x674332)
        return b
    }()
    
}

extension Roulette {
    
    fileprivate func cornerRadius() {
//        self.viewCenter.layer.cornerRadius = (self.frame.width * 0.4) / 2
//        self.viewCenter.clipsToBounds = false
//        self.viewBorder.layer.shadowColor = UIColor.black.cgColor
//        self.viewBorder.layer.shadowOpacity = 1.0
//        self.viewBorder.layer.shadowRadius = 4
//        self.viewBorder.layer.shadowOffset = CGSize(width: 1, height: 4)
//        self.viewCenter.layer.masksToBounds = true
        self.viewBorder.layer.cornerRadius = (self.frame.width) / 2
//        self.viewBorder.clipsToBounds = true
        self.viewMedium.layer.cornerRadius = (self.frame.width * 0.6) / 2
        self.viewMedium.clipsToBounds = true
    }
    
    fileprivate func createViews(rect: CGRect) {
        
        self.viewCenter.addSubview(v)
        
        v.centerYAnchor.constraint(equalTo: viewCenter.centerYAnchor, constant: 0).isActive = true
        v.centerXAnchor.constraint(equalTo: viewCenter.centerXAnchor, constant: 0).isActive = true
        v.widthAnchor.constraint(equalToConstant: 150).isActive = true
        v.heightAnchor.constraint(equalToConstant: 150).isActive = true
        v.layer.cornerRadius = 75
        
        self.viewCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewCenter.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewCenter.widthAnchor.constraint(equalToConstant: rect.width * 0.45).isActive = true
        self.viewCenter.heightAnchor.constraint(equalToConstant: rect.width * 0.45).isActive = true
        
        self.viewMedium.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewMedium.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewMedium.widthAnchor.constraint(equalToConstant: rect.width * 0.6).isActive = true
        self.viewMedium.heightAnchor.constraint(equalToConstant: rect.width * 0.6).isActive = true
        
        self.viewBorder.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewBorder.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.viewBorder.widthAnchor.constraint(equalToConstant: rect.width).isActive = true
        self.viewBorder.heightAnchor.constraint(equalToConstant: rect.width).isActive = true
        
    }
    
    func setupColorsVD() {
        self.viewBorder.backgroundColor = UIColor.colorFromHex(0xFBEBCD)
        self.viewMedium.backgroundColor = UIColor.colorFromHex(0xFBEBCD)
    }
    
}










