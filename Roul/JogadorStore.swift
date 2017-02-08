//
//  JogadorStore.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 08/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class JogadorStore: NSObject {
    private var avatars : [UIImage] = [#imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5"), #imageLiteral(resourceName: "avatar6"), #imageLiteral(resourceName: "avatar7")]
    private var jogadores : [Jogador] = []
    
    static let singleton = JogadorStore()
    
    private override init(){
        super.init()
    }
    
    func getJogadores() -> [Jogador] {
        if !self.jogadores.isEmpty {
            return self.jogadores
        }
        self.jogadores = avatars.map { (image: UIImage) -> Jogador in
            return Jogador(dic: ["nome" : "Deivid", "imagem": image])
        }
        
        return jogadores
    }
    
    
}
