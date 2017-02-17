//
//  Jogador.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 08/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

public enum TypeJogador: String {
    case jogador
    case coringa
}

class Jogador: NSObject {
    
    var nome : String?
    var id : String?
    var imagem : UIImage?
    
    var type: TypeJogador = .jogador

    override var description: String {
        return "(\(self.nome) | \(self.type.rawValue))"
    }
    
    convenience init(_ type: TypeJogador) {
        self.init()
        self.type = type
        switch type {
        case .coringa:
            self.imagem = #imageLiteral(resourceName: "userM")
            break
        case .jogador:
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
