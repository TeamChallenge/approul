//
//  HomeViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet fileprivate weak var timerProgressComponent: TimerProgress!
    @IBOutlet fileprivate weak var rouletteComponent: RouletteView!
    @IBOutlet fileprivate weak var rouletteOptionComponent: RouletteOption!
    @IBOutlet fileprivate weak var desafiante: UIImageView!
    @IBOutlet fileprivate weak var desafiado: UIImageView!
    @IBOutlet fileprivate weak var labelDesafiante: UILabel!
    @IBOutlet fileprivate weak var labelDesafiado: UILabel!
    @IBOutlet fileprivate weak var labelMensagem: UILabel!
    
    private let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Girar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var imgDesafiadoAnteriormente = UIImage()
    private var nameDesafiadoAnteriormente : String?
    
    private func startGame () {
        if let count = self.rouletteComponent.jogadores?.count {
            self.rouletteComponent?.girar(withIntensidade: Int.randomInt(min: 50*count, max: 150*count), { (jogador: Jogador?) in
                self.desafiante.image = jogador?.imagem
                self.labelDesafiante.text = jogador?.nome
                
                self.imgDesafiadoAnteriormente = (jogador?.imagem)!
//                self.nameDesafiadoAnteriormente = (jogador?.nome)!
                
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
        
//        self.rouletteComponent.layer.position = self.view.center
//        self.timerProgressComponent.layer.position = self.view.center
//        self.timerProgressComponent.layer.position.y += 2000
//        self.rouletteOptionComponent.layer.position = self.view.center
//        self.rouletteOptionComponent.layer.position.y += 2000
    }
    
    @objc private func girar (sender: UIButton) {
//        self.timerProgressComponent.startAnimation(withTimer: 30) { 
//            print("Tempo acabado")
//        }
        self.rouletteOptionComponent.startAnimation()
//        let inicialRoletaView = self.rouletteComponent.layer.position
//        let finalRoletaView = CGPoint(x: inicialRoletaView.x - 2000, y: inicialRoletaView.y)
//        
//        self.rouletteComponent.animacaoMove(inicial: inicialRoletaView, final: finalRoletaView) {
//            
//            let inicialTimer = self.timerProgressComponent.layer.position
//            let finalTimer = CGPoint(x: inicialTimer.x, y: inicialTimer.y - 2000)
//            
//            self.timerProgressComponent.animacaoMove(inicial: inicialTimer, final: finalTimer, completion: {
//                
//                self.timerProgressComponent.startAnimation(withTimer: 10, completion: { 
//                    self.timerProgressComponent.animacaoMove(inicial: finalTimer, final: inicialTimer, completion: {
//                        
//                        self.rouletteComponent.animacaoMove(inicial: finalRoletaView, final: inicialRoletaView, completion: {
//                            
//                        })
//                        
//                    })
//                })
//
//            })
//        }
        
    }
    
    private func addGesture(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        self.rouletteComponent.addGestureRecognizer(pan)
    }
    
    private var verificaPrimeiroGiroRoleta = false

    @objc private func handlePan(gesture: UIPanGestureRecognizer){
        
        if gesture.state == .began{
            let velocity = gesture.velocity(in: self.view)
            let intensidade = Int(max(abs(velocity.x), abs(velocity.y)))
            self.rouletteComponent.girar(withIntensidade: intensidade, { (jogador: Jogador?) in
                
                if let type = jogador?.type, type == .coringa {
                    self.labelMensagem.text = "Coringa premiado"
                    return
                } else {
                    self.labelMensagem.text = nil
                }
                
                
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
    
    private func animationTrocaJogadores(){
        self.desafiante.image = #imageLiteral(resourceName: "userF")
    }
    
}



















