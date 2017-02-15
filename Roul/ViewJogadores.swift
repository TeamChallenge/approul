//
//  ViewJogadores.swift
//  Roul
//
//  Created by Renata da Silva Nunes on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class ViewJogadores: UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        configConstraints()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    var imgJogador1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.black
        
        return image
    }()
    
    var imgJogador2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.black
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

    func configImagesNames(jog1: UIImage, jog2: UIImage, name1: String, name2: String){
        self.imgJogador1.image = jog1
        self.imgJogador2.image = jog2
        self.nameJogador1.text = name1
        self.nameJogador2.text = name2
    }
    
}












