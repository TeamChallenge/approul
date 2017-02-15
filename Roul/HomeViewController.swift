//
//  HomeViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var rouletteComponent: RouletteView!
    @IBOutlet weak var desafiante: UIImageView!
    @IBOutlet weak var desafiado: UIImageView!
    @IBOutlet weak var labelDesafiante: UILabel!
    @IBOutlet weak var labelDesafiado: UILabel!
    @IBOutlet weak var viewJogadores: ViewJogadores!
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Girar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var imgDesafiadoAnteriormente: UIImage?
    var nameDesafiadoAnteriormente : String?
    
    private func startGame () {
        if let count = self.rouletteComponent.jogadores?.count {
            self.rouletteComponent?.girar(withIntensidade: count * 7, { (jogador: Jogador?) in
                self.desafiante.image = jogador?.imagem
                self.labelDesafiante.text = jogador?.nome
                
                self.imgDesafiadoAnteriormente = (jogador?.imagem)!
                self.nameDesafiadoAnteriormente = (jogador?.nome)!
                
                self.animationTrocaJogadores()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRoulette()
        self.viewJogadores.configConstraints()
        self.addGesture()
        self.view.addSubview(self.button)
        
        self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.button.addTarget(self, action: #selector(HomeViewController.girar), for: .primaryActionTriggered)
    }
    
    
    private func setupRoulette () {
        var jogadores = JogadorStore.singleton.getJogadores()
        
        jogadores.enumerated().forEach { (tupla: (offset: Int, element: Jogador)) in
            if tupla.offset % 3 == 0 {
                jogadores.insert(Jogador(.coringa), at: tupla.offset)
            }
        }
        
        self.rouletteComponent.jogadores = jogadores

        delay(2) {
            self.startGame()
        }
    }
    
    func girar (sender: UIButton) {
        
    }
    
    func addGesture(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        self.rouletteComponent.addGestureRecognizer(pan)
    }
    
    var verificaPrimeiroGiroRoleta = false

    func handlePan(gesture: UIPanGestureRecognizer){
        
        if gesture.state == .began{
            let velocity = gesture.velocity(in: self.view)
            let intensidade = Int(max(abs(velocity.x), abs(velocity.y)))
            self.rouletteComponent.girar(withIntensidade: intensidade, { (jogador: Jogador?) in
                
                if let jog1 = self.imgDesafiadoAnteriormente, let jog2 = jogador?.imagem, let name1 = self.nameDesafiadoAnteriormente, let name2 = jogador?.nome{
                    self.viewJogadores.configImagesNames(jog1: jog1, jog2: jog2, name1: name1, name2: name2)
                    self.imgDesafiadoAnteriormente = jog2
                    self.nameDesafiadoAnteriormente = name2
                }
                
            })
        }
    }
    
    func animationTrocaJogadores(){
        self.desafiante.image = #imageLiteral(resourceName: "userF")
    }
    
}









