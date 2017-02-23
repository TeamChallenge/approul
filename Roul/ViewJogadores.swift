//
//  ViewJogadores.swift
//  Roul
//
//  Created by Renata da Silva Nunes on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class CardJogador: UIView {

    var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Western", size: 20)
        l.text = "Procurado"
        l.textAlignment = .center
        l.textColor = UIColor.brown
        return l
    }()
    
    var image: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = #imageLiteral(resourceName: "caveira300")
        i.contentMode = .scaleAspectFit
        return i
    }()

    
    private var imageBackground: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = #imageLiteral(resourceName: "bg_avatar")
        i.contentMode = .scaleAspectFit
        i.shadowButton()
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    func setupViews() {
        self.addSubview(self.imageBackground)
        self.addSubview(self.label)
        self.addSubview(self.image)
        
        
        self.imageBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.imageBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.imageBackground.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        self.imageBackground.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        
        self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.label.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        self.label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        self.image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        self.image.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: 20).isActive = true
    }
    
}

class ViewJogadores: UIView {
    
    var cardJogador1 : CardJogador = {
        let c = CardJogador()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    var cardJogador2 : CardJogador = {
        let c = CardJogador()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configConstraints()
    }
    
    fileprivate var labelX : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Western", size: 50)
        l.text = "X"
        l.textAlignment = .center
        l.textColor = UIColor.black
        return l
    }()
    
    fileprivate var point1: CGPoint = CGPoint.zero
    fileprivate var point2: CGPoint = CGPoint.zero
    fileprivate var point1Label: CGPoint = CGPoint.zero
    fileprivate var point2Label: CGPoint = CGPoint.zero
    fileprivate var isFirstJogador: Bool = true
    
    var desafiante: Jogador?
    var desafiado: Jogador?
    
    private func configConstraints(){
        
        self.addSubview(self.cardJogador1)
        self.addSubview(self.labelX)
        self.addSubview(self.cardJogador2)
        
        self.labelX.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.labelX.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.labelX.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.labelX.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.cardJogador1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.cardJogador1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.cardJogador1.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        self.cardJogador1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.cardJogador2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.cardJogador2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.cardJogador2.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        self.cardJogador2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.backgroundColor = .clear
        
//        self.cardJogador1.alpha = 0
//        self.cardJogador2.alpha = 0
//        self.labelX.alpha = 0
        
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

extension ViewJogadores {
    
    func setupTroca(withJogador jogador: Jogador) {
            
            self.cardJogador1.image.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            self.cardJogador1.label.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            
            self.cardJogador2.image.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            self.cardJogador2.label.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            
            self.desafiante = desafiado
            self.desafiado = jogador
            
            delay(1) {
                self.cardJogador2.image.image = jogador.imagem
                self.cardJogador2.label.text = jogador.nome
                
                self.cardJogador1.image.image = self.desafiado?.imagem
                self.cardJogador1.label.text = self.desafiado?.nome
                
                self.cardJogador1.image.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
                self.cardJogador1.label.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
                
                self.cardJogador2.image.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
                self.cardJogador2.label.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            }
    }

    
    func setup(withJogador jogador: Jogador) {
        if self.isFirstJogador {
            
            self.cardJogador1.image.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            self.cardJogador1.label.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            
            self.desafiante = jogador
            
            delay(1) {
                self.cardJogador1.image.image = jogador.imagem
                self.cardJogador1.label.text = jogador.nome
                
                self.cardJogador1.image.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
                self.cardJogador1.label.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            }
            
//            self.cardJogador1.layer.add(animationFade(from: 0, to: 1), forKey: "fade")
            
            self.isFirstJogador = false
//            self.point1 = self.cardJogador1.layer.position
//            self.point2 = self.cardJogador2.layer.position
        } else {
            
            self.cardJogador2.image.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            self.cardJogador2.label.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
            
            self.desafiado = jogador
            
            delay(1) {
                self.cardJogador2.image.image = jogador.imagem
                self.cardJogador2.label.text = jogador.nome
                
                self.cardJogador2.image.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
                self.cardJogador2.label.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            }
            
//            self.labelX.layer.add(animationFade(from: 0, to: 1), forKey: "fade")
//            self.cardJogador2.layer.add(animationFade(from: 0, to: 1), forKey: "fade")
        }
    }
    
    func animationTroca() {
        
//        self.cardJogador2.layer.add(animationMove(self.point2, self.point1), forKey: "move")
//        self.cardJogador1.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
//        self.labelX.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
        self.cardJogador1.image.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
        self.cardJogador1.label.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
        self.cardJogador2.image.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
        self.cardJogador2.label.layer.add(animationFade(from: 1, to: 0), forKey: "fade")
        
        self.desafiante = desafiado
        self.desafiado = nil
        
        delay(1) {
            self.cardJogador1.image.image = self.cardJogador2.image.image
            self.cardJogador1.label.text = self.cardJogador2.label.text
            
            self.cardJogador2.image.image = #imageLiteral(resourceName: "caveira300")
            self.cardJogador2.label.text = ""
            
            self.cardJogador1.image.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            self.cardJogador1.label.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            self.cardJogador2.image.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            self.cardJogador2.label.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
            
//            self.cardJogador2.image.image = #imageLiteral(resourceName: "caveira300")
            
            delay(1) {
                self.cardJogador2.layer.removeAllAnimations()
                self.cardJogador1.layer.removeAllAnimations()
                self.labelX.layer.removeAllAnimations()
            }
            
            
//            self.imgJogador1.image = self.imgJogador2.image
//            self.nameJogador1.text = self.nameJogador2.text
//            self.imgJogador2.image = #imageLiteral(resourceName: "userM")
//            
//            self.imgJogador1.layer.removeAllAnimations()
//            self.imgJogador2.layer.removeAllAnimations()
//            self.nameJogador2.layer.removeAllAnimations()
//            self.nameJogador1.layer.removeAllAnimations()
            
//            self.cardJogador1.layer.opacity = 1
//            self.cardJogador2.layer.position = self.point2
            
//            self.imgJogador1.layer.opacity = 1
//            self.imgJogador2.layer.position = self.point2
//            self.nameJogador2.layer.position = self.point2Label
//            self.imgJogador2.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
//            self.nameJogador2.alpha = 0
        }
    }
    
}
