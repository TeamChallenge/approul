//
//  JogadorStore.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 08/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class JogadorStore: NSObject {
    
    private var avatars : [(String, UIImage)] = [("A", #imageLiteral(resourceName: "avatar1")), ("B", #imageLiteral(resourceName: "avatar2")), ( "C", #imageLiteral(resourceName: "avatar3")), ("D", #imageLiteral(resourceName: "avatar4")), ("E", #imageLiteral(resourceName: "avatar5")), ("F", #imageLiteral(resourceName: "avatar6"))]
//    ("G", #imageLiteral(resourceName: "avatar7"))
    private var jogadores : [Jogador] = []
    
    static let singleton = JogadorStore()
    
    private override init(){
        super.init()
    }
    
    func getJogadores() -> [Jogador] {
        if !self.jogadores.isEmpty {
            return self.jogadores
        }
        self.jogadores = avatars.map { (nome: String, image: UIImage) -> Jogador in
            return Jogador(dic: ["nome" : nome, "imagem": image])
        }
        
        return jogadores
    }
    
    
}
