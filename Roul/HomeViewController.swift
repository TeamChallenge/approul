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
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Girar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var imgDesafiadoAnteriormente = UIImage()
    var imgDesafiado = UIImage()
    var nameDesafiadoAnteriormente = String()
    var nameDesafiado = String()
    
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
            self.rouletteComponent.girar(withIntensidade: Int(velocity.y),{ (jogador: Jogador?) in
                
                if self.verificaPrimeiroGiroRoleta == false{
                    self.desafiado.image = jogador?.imagem
                    self.imgDesafiado = (jogador?.imagem)!
                    self.imgDesafiadoAnteriormente = (jogador?.imagem)!
                    
                    self.labelDesafiado.text = jogador?.nome
                    self.nameDesafiado = (jogador?.nome)!
                    self.nameDesafiadoAnteriormente = (jogador?.nome)!
                    
                    self.verificaPrimeiroGiroRoleta = true
                }
                else{
                    self.desafiante.image = self.imgDesafiadoAnteriormente
                    self.desafiado.image = jogador?.imagem
                    self.imgDesafiado = (jogador?.imagem)!
                    
                    self.labelDesafiante.text = self.nameDesafiadoAnteriormente
                    self.labelDesafiado.text = jogador?.nome
                    self.nameDesafiado = (jogador?.nome)!
                }
                
                self.animationInModal()
                
            })
        }
    }
    
    func animationInModal(){
        delay(1, finish: {
            self.performSegue(withIdentifier: "modalSegue", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalSegue"{
            if let VC = segue.destination as? ModalDuelo{
                VC.imageJog1 = self.imgDesafiadoAnteriormente
                VC.imageJog2 = self.imgDesafiado
                self.imgDesafiadoAnteriormente = self.imgDesafiado
                
                VC.nameJog1 = self.nameDesafiadoAnteriormente
                VC.nameJog2 = self.nameDesafiado
                self.nameDesafiadoAnteriormente = self.nameDesafiado
            }
        }
    }
}









