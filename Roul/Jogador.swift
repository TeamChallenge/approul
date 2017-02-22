//
//  Jogador.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 08/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

public enum TypeJogador: String {
    case player
    case coringa
}

class Jogador: NSObject {
    
    var coringa: Coringa?
    var nome : String?
    var id : String?
    var imagem : UIImage?
    
    var type: TypeJogador = .player

    override var description: String {
        return "(\(self.nome) | \(self.type.rawValue))"
    }
    
    convenience init(_ type: TypeJogador) {
        self.init()
        self.type = type
        switch type {
        case .coringa:
            self.imagem = #imageLiteral(resourceName: "caveira300")
            break
        case .player:
            break
        }
    }
    
    convenience init(dic: [String: Any]) {
        self.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if responds(to: NSSelectorFromString(key)){
            super.setValue(value, forKey: key)
        }
    }
}
