//
//  HomeViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var timerViewComponet: TimerView!
    @IBOutlet weak var rouletteComponent: RouletteView!
    @IBOutlet weak var desafiante: UIImageView!
    @IBOutlet weak var desafiado: UIImageView!
    @IBOutlet weak var labelDesafiante: UILabel!
    @IBOutlet weak var labelDesafiado: UILabel!
    
    var jogadores : [Jogador]?
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Girar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var imgDesafiadoAnteriormente = UIImage()
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
        self.addGesture()
        self.view.addSubview(self.button)
        
        self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.button.addTarget(self, action: #selector(HomeViewController.girar), for: .primaryActionTriggered)
    }
    
    private func setupRoulette () {
        guard var jogadores = self.jogadores else {
            print("Sem jogadores")
            return
        }
        
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
        self.timerViewComponet.start(withTime: 3, completion: {
            print("Fim do tempo")
        })
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
                
                if jogador?.imagem == self.imgDesafiadoAnteriormente{
//                    self.rouletteComponent.girar(withIntensidade: 10) { (jogadorRodada2: Jogador?) in
//                        print(jogador!)
//                        
//                        self.desafiado.image = jogadorRodada2?.imagem
//                        self.labelDesafiado.text = jogadorRodada2?.nome
                        self.desafiante.image = self.imgDesafiadoAnteriormente
                        self.labelDesafiante.text = self.nameDesafiadoAnteriormente
//
//                        self.imgDesafiadoAnteriormente = (jogadorRodada2?.imagem)!
//                        self.nameDesafiadoAnteriormente = (jogadorRodada2?.nome)!
//
//                        self.animationInModal()
//                    }
                }
                else{
                    self.desafiado.image = jogador?.imagem
                    self.labelDesafiado.text = jogador?.nome
                    self.desafiante.image = self.imgDesafiadoAnteriormente
                    self.labelDesafiante.text = self.nameDesafiadoAnteriormente
                    
                    self.imgDesafiadoAnteriormente = (jogador?.imagem)!
                    self.nameDesafiadoAnteriormente = jogador?.nome
                    
//                    self.animationInModal()
                }
            })
        }
    }
    
    func animationTrocaJogadores(){
        self.desafiante.image = #imageLiteral(resourceName: "userF")
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalSegue"{
            if let VC = segue.destination as? ModalDuelo{
                VC.imageJog1 = self.desafiante.image!
                VC.imageJog2 = self.desafiado.image!
                
                VC.nameJog1 = self.labelDesafiante.text!
                VC.nameJog2 = self.labelDesafiado.text!
            }
        }
    }
    
    func invertePosicaoJogador(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: { 
            self.desafiante.center.x = self.desafiante.center.x - 100.0
        }, completion: nil)
    }

}









