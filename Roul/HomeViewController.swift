//
//  HomeViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var viewJogadorComponent: ViewJogadores!
    @IBOutlet fileprivate weak var timerProgressComponent: TimerProgress!
    @IBOutlet fileprivate weak var rouletteComponent: RouletteView!
    @IBOutlet fileprivate weak var rouletteOptionComponent: RouletteView!
    @IBOutlet fileprivate weak var labelMensagem: UILabel!

    
    var jogadores : [Jogador]?
    
    fileprivate var focusGuide = UIFocusGuide()
    fileprivate var focusGuideMenu = UIFocusGuide()

    fileprivate func setupSubviews() {
        self.view.addLayoutGuide(self.focusGuide)
        self.view.addLayoutGuide(self.focusGuideMenu)
        
//        self.focusGuide.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.focusGuide.topAnchor.constraint(equalTo: self.rouletteComponent.bottomAnchor).isActive = true
//        self.focusGuide.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        self.focusGuide.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
//        self.focusGuideMenu.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
//        self.focusGuideMenu.topAnchor.constraint(equalTo: self.buttonMenu.bottomAnchor).isActive = true
//        self.focusGuideMenu.widthAnchor.constraint(equalToConstant: 90).isActive = true
//        self.focusGuideMenu.bottomAnchor.constraint(equalTo: self.collectionMundos.bottomAnchor).isActive = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        guard let nextFocusedView = context.nextFocusedView else { return }
        
//        switch nextFocusedView {
//        case self.buttonMenu:
//            self.focusGuideMenu.preferredFocusedView = self.rouletteComponent
//            break
//        case self.rouletteComponent:
//            self.focusGuideMenu.preferredFocusedView = self.buttonMenu
//            break
//        case self.timerProgressComponent:
//            self.focusGuideMenu.preferredFocusedView = self.buttonMenu
//            break
//        default:
//            self.focusGuideMenu.preferredFocusedView = nil
//        }
    }
    
    var collectionIsVisible: Bool = false
    
    @IBAction func handlerMenu() {
        self.performSegue(withIdentifier: "modal", sender: self)
//        if self.collectionIsVisible == false {
//            self.collectionIsVisible = true
//            let t = CGAffineTransform(translationX: 320, y: 0)
//            UIView.animate(withDuration: 0.5, animations: { 
//                self.collectionMundos.transform = t
//                self.buttonMenu.transform = t
//            }, completion: nil)
//        } else {
//            self.collectionIsVisible = false
//            let t = CGAffineTransform(translationX: 0, y: 0)
//            UIView.animate(withDuration: 0.5, animations: {
//                self.collectionMundos.transform = t
//                self.buttonMenu.transform = t
//            }, completion: nil)
//        }
        
    }
    
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
            self.rouletteComponent?.girar(withIntensidade: count * 200, { (jogador: Jogador?) in
                if let j = jogador {
                    self.viewJogadorComponent.setup(withJogador: j)
                    self.rouletteComponent.clicado = false
                    self.rouletteComponent.setGiro(giro: true)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRoulette()
        self.addGesture()
        self.setupSubviews()
//        self.view.addSubview(self.button)
//        
//        self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 550).isActive = true
//        self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
//        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
//        self.button.addTarget(self, action: #selector(HomeViewController.mudar), for: .primaryActionTriggered)
//        self.collectionMundos.backgroundColor = .clear
        self.rouletteOptionComponent.backgroundColor = .clear
        self.labelMensagem.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupRoulette () {
        guard var jogadores = self.jogadores else {
            print("Sem jogadores")
            return
        }
        self.rouletteComponent.backgroundColor = .clear
        let mod = (self.jogadores!.count / 2) + 1
        var coringas = CoringaStore.singleton.getAll()
//        jogadores.enumerated().forEach { (tupla: (offset: Int, element: Jogador)) in
//            if tupla.offset % mod == 0 {
//                let index = Int.randomInt(min: 0, max: coringas.count - 1)
//                let j = Jogador(.coringa)
//                let removeCoringa = coringas.remove(at: index)
//                j.coringa = removeCoringa
//                jogadores.insert(j, at: tupla.offset)
//            }
//        }
        
        self.rouletteComponent.jogadores = jogadores

        delay(2) {
            self.rouletteComponent.clicado = true
            self.startGame()
        }
        self.rouletteOptionComponent.options = [("Verdade",#imageLiteral(resourceName: "verdade")), ("Desafio", #imageLiteral(resourceName: "desafio")), ("Interrogação", #imageLiteral(resourceName: "interrogacao"))]
        
        self.rouletteComponent.layer.position = self.view.center
        self.timerProgressComponent.layer.position = self.view.center
        self.timerProgressComponent.layer.position.y += 1300
        self.rouletteOptionComponent.layer.position = self.view.center
        self.rouletteOptionComponent.layer.position.y += 1300
    }
    
    @objc private func mudar () {
        self.viewJogadorComponent.animationTroca()
    }
    
    var textLabel: String = ""
    
    @objc private func animacaoComponents () {
        
        guard let desafiante = self.viewJogadorComponent.desafiante?.nome, let desafiado = self.viewJogadorComponent.desafiado?.nome else {
            return
        }
        
        self.labelMensagem.alpha = 1
        self.labelMensagem.text = "\(desafiante) pode desafiar \(desafiado)"
        
        // Pontos da roleta de jogadores
        let inicialRoletaView = self.rouletteComponent.layer.position
        let finalRoletaView = CGPoint(x: inicialRoletaView.x - 1300, y: inicialRoletaView.y)
        
        // Saida da roleta de Jogadores
        self.rouletteComponent.clicado = false
        self.rouletteComponent.isRodando = true
        self.rouletteComponent.clique()
        
        delay(1) { 
            self.rouletteComponent.animacaoMove(inicial: inicialRoletaView, final: finalRoletaView) {
                
                // Pontos da roleta de opções
                let inicialVD = self.rouletteOptionComponent.layer.position
                let finalVD = CGPoint(x: inicialVD.x, y: inicialVD.y - 1300)
                
                // Entrada da roleta de opções
                self.rouletteOptionComponent.animacaoMove(inicial: inicialVD, final: finalVD, completion: {
                    
                    // Definir texto do desafio
                    self.labelMensagem.text = "Será verdade ou desafio?"
                    
                    delay(2, finish: {
                        
                        // Animação da roleta de opções
                        self.rouletteOptionComponent.girarOptions(withIntensidade: Int.randomInt(min: 400, max: 1000), { (opcao: String) in
                            
                            self.labelMensagem.text = opcao
                            
                            delay(1, finish: {
                                
                                if opcao == "Verdade" {
                                    self.textLabel = "\(desafiante) pode fazer uma pergunta para \(desafiado)"
                                } else if opcao == "Desafio" {
                                    self.textLabel = "\(desafiante) faz um desafio para \(desafiado)"
                                    self.performSegue(withIdentifier: "modal", sender: self)
                                } else {
                                    self.textLabel = "\(desafiante) a decisão é sua!"
                                }
                                //
                                
                                //                            // Saida da roleta de opções
                                self.rouletteOptionComponent.animacaoMove(inicial: finalVD, final: inicialVD, completion: {
                                    //
                                    //                                // Pontos da roleta de tempo
                                    //                                let inicalTimer = self.timerProgressComponent.layer.position
                                    //                                let finalTimer = CGPoint(x: inicalTimer.x, y: inicalTimer.y - 1300)
                                    //
                                    //                                self.focusGuide.preferredFocusedView = self.timerProgressComponent.button
                                    //                                self.setNeedsFocusUpdate()
                                    //                                self.updateFocusIfNeeded()
                                    //
                                    //                                // Entrada da roleta de tempo
                                    //                                self.timerProgressComponent.animacaoMove(inicial: inicalTimer, final: finalTimer, completion: {
                                    //
                                    //                                    // Animação do tempo
                                    //                                    self.timerProgressComponent.set(withTimer: 10, completion: {
                                    //                                        print("Tempo acabou")
                                    //
                                    //                                        // Saida da roleta de tempo
                                    //                                        self.timerProgressComponent.animacaoMove(inicial: finalTimer, final: inicalTimer, completion: {
                                    //
                                    //                                            // Entrada da roleta de jogadores
                                    self.rouletteComponent.animacaoMove(inicial: finalRoletaView, final: inicialRoletaView, completion: {
                                        if opcao == "Verdade" || opcao == "Interrogação"{
                                            self.reload()
                                        }
                                        //
                                        //                                                self.rouletteComponent.isRodando = false
                                        //                                                self.viewJogadorComponent.animationTroca()
                                        //                                                self.labelMensagem.text = "\(desafiado) sua vez de girar a roleta"
                                        //                                                self.rouletteComponent.setGiro(giro: true)
                                        //                                                self.focusGuide.preferredFocusedView = self.rouletteComponent
                                        //                                                //                                            self.focusGuideMenu.preferredFocusedView = self.rouletteComponent
                                        //                                                self.setNeedsFocusUpdate()
                                        //                                                self.updateFocusIfNeeded()
                                        //                                                
                                    })
                                    //
                                    //                                        })
                                    //                                    })
                                    //                                    
                                    //                                })
                                    //                                
                                })
                                
                            })
                            
                            
                            
                        })
                        
                    })
                    
                })
            }
        }
        
        

//            let inicialTimer = self.timerProgressComponent.layer.position
//            let finalTimer = CGPoint(x: inicialTimer.x, y: inicialTimer.y - 1300)

    }
    
    func reload() {
        guard let desafiante = self.viewJogadorComponent.desafiante?.nome, let desafiado = self.viewJogadorComponent.desafiado?.nome else {
            return
        }
        self.rouletteComponent.isRodando = false
        self.viewJogadorComponent.animationTroca()
        self.labelMensagem.text = "\(desafiado) sua vez de girar a roleta"
        self.rouletteComponent.setGiro(giro: true)
        self.focusGuide.preferredFocusedView = self.rouletteComponent
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modal" {
            let v = segue.destination as? ModalTimerViewController
            v?.controller = self
            v?.textoLabel = self.textLabel
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
                        
                        delay(3, finish: { 
                            if removido.name == "Passa vez" {
                                self.rouletteComponent.girar(withIntensidade: 300, { (jogador: Jogador?) in
                                    
                                    if let j = jogador {
                                        if j.type == .player {
                                            self.viewJogadorComponent.setup(withJogador: j)
                                            self.animacaoComponents()
                                        } else if j.type == .coringa {
                                        }
                                    }
                                    
                                })
                            } else if removido.name == "Troca" {
                                guard let desafiante = self.viewJogadorComponent.desafiante, let desafiado = self.viewJogadorComponent.desafiado else {
                                    return
                                }
                                
                                self.viewJogadorComponent.setupTroca(withJogador: desafiante)
                                
                            } else if removido.name == "Eu escolho" {
                                
                            } else if removido.name == "O velho/novo" {
                                
                            }
                        })
                        
                        self.labelMensagem.text = removido.acao
                    }
                }
            })
        }
    }

}



















