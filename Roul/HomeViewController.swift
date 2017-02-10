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
    
    var avatars : [UIImage] = [#imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5"), #imageLiteral(resourceName: "avatar6"), #imageLiteral(resourceName: "avatar7"), #imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5"), #imageLiteral(resourceName: "avatar6"), #imageLiteral(resourceName: "avatar7"), #imageLiteral(resourceName: "avatar1")]
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Girar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var IDavatarDesafiado = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRoulette()
        self.addGesture()
        self.view.addSubview(self.button)
        
        self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        self.button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.button.addTarget(self, action: #selector(HomeViewController.girar), for: .primaryActionTriggered)
    }
    
    private func setupRoulette () {
        self.rouletteComponent.jogadores = JogadorStore.singleton.getJogadores()
    }
    
    func girar (sender: UIButton) {
        self.rouletteComponent.girar(withIntensidade: 35) { (jogador: Jogador?) in
            print(jogador!)
        }
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
                
                if self.verificaPrimeiroGiroRoleta == false{
                    self.IDavatarDesafiado = (jogador?.imagem)!
                    self.desafiado.image = self.IDavatarDesafiado
                }
                else{
                    self.desafiante.image = self.IDavatarDesafiado
                    self.desafiado.image = jogador?.imagem
                    self.IDavatarDesafiado = (jogador?.imagem)!
                }
                
                self.verificaPrimeiroGiroRoleta = true

            })
        }
        
        
    }
}
