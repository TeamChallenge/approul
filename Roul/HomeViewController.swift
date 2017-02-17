//
//  HomeViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var viewJogadores: ViewJogadores!
    @IBOutlet fileprivate weak var timerProgressComponent: TimerProgress!
    @IBOutlet fileprivate weak var rouletteComponent: RouletteView!
    @IBOutlet fileprivate weak var rouletteOptionComponent: RouletteOption!
    @IBOutlet fileprivate weak var desafiante: UIImageView!
    @IBOutlet fileprivate weak var desafiado: UIImageView!
    @IBOutlet fileprivate weak var labelDesafiante: UILabel!
    @IBOutlet fileprivate weak var labelDesafiado: UILabel!
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
                if let jogador = jogador {
                    self.viewJogadores.setup(jogador: jogador)
                }
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
        
        self.rouletteComponent.layer.position = self.view.center
        self.timerProgressComponent.layer.position = self.view.center
        self.timerProgressComponent.layer.position.y += 1300
        self.rouletteOptionComponent.layer.position = self.view.center
        self.rouletteOptionComponent.layer.position.y += 1300
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
                
                if self.viewJogadores.isFirst == false, let jogador = jogador{
                    self.viewJogadores.setup(jogador: jogador)
                    return
                }
                if let jogador = jogador {
                    self.viewJogadores.animationTroca(jog: jogador)
                }
//                guard let imgDesafiante = self.imgDesafiadoAnteriormente, let nameDesafiante = self.nameDesafiadoAnteriormente else{
//                    return
//                }
//                
//                let dic: [String: Any] = ["name": nameDesafiante, "image": imgDesafiante]
//                
//                guard let jog = jogador else{
//                    return
//                }
                
//                self.viewJogadores.configImagesNames(jogador2: jog, jogador1: dic)
//                self.imgDesafiadoAnteriormente = jog.imagem
//                self.nameDesafiadoAnteriormente = jog.nome
                
//                self.viewJogadores.animationTroca(jog: jog)
                
//                if let jog1 = self.imgDesafiadoAnteriormente, let jog2 = jogador?.imagem, let name1 = self.nameDesafiadoAnteriormente, let name2 = jogador?.nome{
//                    self.viewJogadores.configImagesNames(jog1: jog1, jog2: jog2, name1: name1, name2: name2)
//                    self.imgDesafiadoAnteriormente = jog2
//                    self.nameDesafiadoAnteriormente = name2
//                }
                
            })
        }
    }
    
    private func animationTrocaJogadores(){
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



















