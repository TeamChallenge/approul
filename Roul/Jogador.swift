//
//  Jogador.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 08/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class Jogador: NSObject {
    var nome : String?
    var id : String?
    var imagem : UIImage?
    
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
