//
//  ViewJogadores.swift
//  Roul
//
//  Created by Renata da Silva Nunes on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class ViewJogadores: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configConstraints()
    }

    var imgJogador1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.backgroundColor = UIColor.black
        return image
    }()
    
    var imgJogador2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.backgroundColor = UIColor.black
        return image
    }()
    
    var nameJogador1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jogador 1"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    var nameJogador2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jogador 2"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    fileprivate var point1: CGPoint = CGPoint.zero
    fileprivate var point2: CGPoint = CGPoint.zero
    
    func configConstraints(){
        self.addSubview(self.imgJogador1)
        self.imgJogador1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25).isActive = true
        self.imgJogador1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        self.imgJogador1.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.imgJogador1.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.addSubview(self.imgJogador2)
        self.imgJogador2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25).isActive = true
        self.imgJogador2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true
        self.imgJogador2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.imgJogador2.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.addSubview(self.nameJogador1)
        self.nameJogador1.centerXAnchor.constraint(equalTo: self.imgJogador1.centerXAnchor).isActive = true
        self.nameJogador1.topAnchor.constraint(equalTo: self.imgJogador1.bottomAnchor, constant: 10).isActive = true
        
        self.addSubview(self.nameJogador2)
        self.nameJogador2.centerXAnchor.constraint(equalTo: self.imgJogador2.centerXAnchor).isActive = true
        self.nameJogador2.topAnchor.constraint(equalTo: self.imgJogador2.bottomAnchor, constant: 10).isActive = true
        
    }

//    func configImagesNames(jog1: UIImage, jog2: UIImage, name1: String, name2: String){
//        self.imgJogador1.image = jog1
//        self.imgJogador2.image = jog2
//        self.nameJogador1.text = name1
//        self.nameJogador2.text = name2
//    }

    func setup(jogador: Jogador){
        if self.isFirst == true {
            self.imgJogador1.image = jogador.imagem
            self.nameJogador1.text = jogador.nome
            self.isFirst = false
        } else {
            self.imgJogador2.image = jogador.imagem
            self.nameJogador2.text = jogador.nome
            self.isFirst = true
        }
        
        if self.point1 == CGPoint.zero {
            self.point1 = self.imgJogador1.center
            self.point2 = self.imgJogador2.center
        }
    }
    
    var isFirst: Bool = true
    var isAnimation1: Bool = true
    
    func animationTroca(jog: Jogador){
//        let move = CABasicAnimation(keyPath: "position")
//        move.fromValue = NSValue(cgPoint: self.imgJogador2.center)
//        move.toValue = NSValue(cgPoint: self.imgJogador1.center)
//        move.duration = 1
//        move.fillMode = kCAFillModeForwards
//        move.isRemovedOnCompletion = false
//        self.imgJogador2.layer.add(move, forKey: "animationTroca")
//
//        self.imgJogador1.image = self.imgJogador2.image
//        let img = UIImageView(frame: self.imgJogador2.frame)
//        img.image = #imageLiteral(resourceName: "userF")
//        self.addSubview(img)

        if isAnimation1 == true {
            self.imgJogador2.layer.removeAllAnimations()
            self.imgJogador1.layer.removeAllAnimations()

            self.imgJogador2.image = jog.imagem
            self.imgJogador2.layer.add(self.animationMove(self.point2, self.point1), forKey: "move")
            self.imgJogador1.image = #imageLiteral(resourceName: "userF")
            delay(1, finish: { 
                self.imgJogador1.layer.position = self.point2
                self.imgJogador1.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            })
            
            self.isAnimation1 = false
        } else {
            self.imgJogador2.layer.removeAllAnimations()
            self.imgJogador1.layer.removeAllAnimations()
            
            self.imgJogador1.image = jog.imagem
            self.imgJogador1.layer.add(self.animationMove(self.point2, self.point1), forKey: "move")
            self.imgJogador2.image = #imageLiteral(resourceName: "userF")
            
            delay(1, finish: {
                self.imgJogador2.layer.position = self.point2
                self.imgJogador2.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            })
            
            self.isAnimation1 = true
        }
        
        
    }
}

extension ViewJogadores {
    
    func animationMove(_ point1: CGPoint, _ point2: CGPoint) -> CABasicAnimation {
        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: point1)
        move.toValue = NSValue(cgPoint: point2)
        move.duration = 1
        move.fillMode = kCAFillModeForwards
        move.isRemovedOnCompletion = false
        return move
    }
    
    func animationFade(from: Int, to: Int) -> CABasicAnimation {
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = from
        fade.toValue = to
        fade.duration = 1
        fade.fillMode = kCAFillModeForwards
        fade.isRemovedOnCompletion = false
        return fade
    }
    
}
