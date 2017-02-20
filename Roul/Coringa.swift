//
//  Coringa.swift
//  Roul
//
//  Created by Thiago Vinhote on 20/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import Foundation

struct Coringa {
    
    var acao: String = ""
    var name: String = ""
    
    init(acao: String, name: String) {
        self.acao = acao
        self.name = name
    }
    
}

class CoringaStore: NSObject {
    
    static let singleton: CoringaStore = CoringaStore()
    
    private override init() {
        super.init()
    }
    
    func getAll() -> [Coringa] {
        return [Coringa(acao: "O próximo jogador deve jogar", name: "Passa vez"),
                Coringa(acao: "Jogador que desafia passa a desafiado", name: "Troca"),
                Coringa(acao: "A roleta escolhe os dois jogadores", name: "Aleatório"),
                Coringa(acao: "Quem desafia escolhe o desafiado", name: "Eu escolho"),
                Coringa(acao: "O mais velho ou novo da partida", name: "O velho/novo")]
    }
    
}
