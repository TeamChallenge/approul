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

    fileprivate var imgJogador1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate var imgJogador2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate var nameJogador1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jogador 1"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    fileprivate var nameJogador2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jogador 2"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    fileprivate var point1: CGPoint = CGPoint.zero
    fileprivate var point2: CGPoint = CGPoint.zero
    fileprivate var isFirstJogador: Bool = true
    
    var desafiante: Jogador?
    var desafiado: Jogador?
    
    private func configConstraints(){
        self.backgroundColor = .clear
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
    
    func setup(withJogador jogador: Jogador) {
        if self.isFirstJogador {
            self.imgJogador1.image = jogador.imagem
            self.nameJogador1.text = jogador.nome
            self.isFirstJogador = false
            self.point1 = self.imgJogador1.layer.position
            self.point2 = self.imgJogador2.layer.position
            self.desafiante = jogador
        } else {
            self.imgJogador2.image = jogador.imagem
            self.nameJogador2.text = jogador.nome
            self.desafiado = jogador
        }
    }
    
    func animationTroca() {
        self.imgJogador2.layer.add(self.animationMove(self.point2, self.point1), forKey: "move")
        self.imgJogador1.layer.add(self.animationFade(from: 1, to: 0), forKey: "fade")
        
        self.desafiante = desafiado
        self.desafiado = nil
        
        delay(1) { 
            self.imgJogador1.image = self.imgJogador2.image
            self.nameJogador1.text = self.nameJogador2.text
            self.imgJogador2.image = #imageLiteral(resourceName: "userM")
            
            self.imgJogador1.layer.removeAllAnimations()
            self.imgJogador2.layer.removeAllAnimations()
            
            self.imgJogador1.layer.opacity = 1
            self.imgJogador2.layer.position = self.point2
            self.imgJogador2.layer.add(self.animationFade(from: 0, to: 1), forKey: "fade")
        }
    }
    
}
