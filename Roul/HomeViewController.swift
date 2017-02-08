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
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Girar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        
        self.rouletteComponent.numberItems = 15
    }
    
    func girar (sender: UIButton) {
        self.rouletteComponent.girar(withIntensidade: 5) { (elemento: CircleView) in
            print(elemento)
        }
    }
    
    func addGesture(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        self.rouletteComponent.addGestureRecognizer(pan)
    }

    func handlePan(gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            let velocity = gesture.velocity(in: self.view)
            self.rouletteComponent.girar(withIntensidade: Int(velocity.y),{ (elemento: CircleView) in
                print(elemento)
            })
            print(velocity)
        }
    }
}
