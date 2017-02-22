//
//  HomeViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionMundos: UICollectionView!
    @IBOutlet weak var viewJogadorComponent: ViewJogadores!
    @IBOutlet fileprivate weak var timerProgressComponent: TimerProgress!
    @IBOutlet fileprivate weak var rouletteComponent: RouletteView!
    @IBOutlet fileprivate weak var rouletteOptionComponent: RouletteOption!
    @IBOutlet fileprivate weak var labelMensagem: UILabel!
    
    
    var jogadores : [Jogador]?
    
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
                if let j = jogador {
                    self.viewJogadorComponent.setup(withJogador: j)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRoulette()
        self.addGesture()
//        self.view.addSubview(self.button)
//        
//        self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 550).isActive = true
//        self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
//        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
//        self.button.addTarget(self, action: #selector(HomeViewController.mudar), for: .primaryActionTriggered)
        self.collectionMundos.backgroundColor = .clear
    }
    
    private func setupRoulette () {
        guard var jogadores = self.jogadores else {
            print("Sem jogadores")
            return
        }
        self.rouletteComponent.backgroundColor = .clear
        let mod = (self.jogadores!.count / 2) + 1
        var coringas = CoringaStore.singleton.getAll()
        jogadores.enumerated().forEach { (tupla: (offset: Int, element: Jogador)) in
            if tupla.offset % mod == 0 {
                let index = Int.randomInt(min: 0, max: coringas.count - 1)
                let j = Jogador(.coringa)
                let removeCoringa = coringas.remove(at: index)
                j.coringa = removeCoringa
                jogadores.insert(j, at: tupla.offset)
            }
        }
        
        self.rouletteComponent.jogadores = jogadores

        delay(2) {
            self.startGame()
        }
        
        self.rouletteComponent.layer.position = self.view.center
        self.timerProgressComponent.layer.position = self.view.center
        self.timerProgressComponent.layer.position.y += 1300
        self.rouletteOptionComponent.layer.position = self.view.center
        self.rouletteOptionComponent.layer.position.y += 1300
    }
    
    @objc private func mudar () {
        self.viewJogadorComponent.animationTroca()
    }
    
    @objc private func animacaoComponents () {
        
        guard let desafiante = self.viewJogadorComponent.desafiante?.nome, let desafiado = self.viewJogadorComponent.desafiado?.nome else {
            return
        }
        
        self.labelMensagem.text = "\(desafiante) pode desafiar \(desafiado)"
        
        // Pontos da roleta de jogadores
        let inicialRoletaView = self.rouletteComponent.layer.position
        let finalRoletaView = CGPoint(x: inicialRoletaView.x - 1300, y: inicialRoletaView.y)
        
        // Saida da roleta de Jogadores
        self.rouletteComponent.animacaoMove(inicial: inicialRoletaView, final: finalRoletaView) {
        
            // Pontos da roleta de opções
            let inicialVD = self.rouletteOptionComponent.layer.position
            let finalVD = CGPoint(x: inicialVD.x, y: inicialVD.y - 1300)
            
            // Entrada da roleta de opções
//            self.rouletteOptionComponent.animacaoMove(inicial: inicialVD, final: finalVD, completion: { 
            
                // Animação da roleta de opções
//                self.rouletteOptionComponent.startAnimation(){
            
                    // Definir texto do desafio
//                    self.labelMensagem.text = "Fulano desafia fulano de tal"
        
                    // Saida da roleta de opções
//                    self.rouletteOptionComponent.animacaoMove(inicial: finalVD, final: inicialVD, completion: {
            
                        // Pontos da roleta de tempo
                        let inicalTimer = self.timerProgressComponent.layer.position
                        let finalTimer = CGPoint(x: inicalTimer.x, y: inicalTimer.y - 1300)
                        
                        // Entrada da roleta de tempo
                        self.timerProgressComponent.animacaoMove(inicial: inicalTimer, final: finalTimer, completion: {

                            // Animação do tempo
                            self.timerProgressComponent.set(withTimer: 10, completion: {
                                print("Tempo acabou")
                                
                                // Saida da roleta de tempo
                                self.timerProgressComponent.animacaoMove(inicial: finalTimer, final: inicalTimer, completion: {
                                
                                    // Entrada da roleta de jogadores
                                    self.rouletteComponent.animacaoMove(inicial: finalRoletaView, final: inicialRoletaView, completion: {
                                        
                                        self.viewJogadorComponent.animationTroca()
                                        self.labelMensagem.text = "\(desafiado) sua vez de girar a roleta"
                                        
                                    })
                        
                                })
                            })
        
                        })
            
//                    })

//                }

//            })

//            let inicialTimer = self.timerProgressComponent.layer.position
//            let finalTimer = CGPoint(x: inicialTimer.x, y: inicialTimer.y - 1300)
            
            
        }

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
                if let j = jogador {
                    if j.type == .player {
                        self.viewJogadorComponent.setup(withJogador: j)
                        self.animacaoComponents()
                    } else if j.type == .coringa {
                        var coringas = CoringaStore.singleton.getAll()
                        let index = Int.randomInt(min: 0, max: coringas.count - 1)
                        let removido = coringas.remove(at: index)
                        
                        self.viewJogadorComponent.setup(withJogador: j)
                        self.labelMensagem.text = removido.acao
                    }
                }
            })
        }
    }

}



















