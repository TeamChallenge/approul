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
        
        self.view.addSubview(self.button)
        
        self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        self.button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.button.addTarget(self, action: #selector(HomeViewController.girar), for: .primaryActionTriggered)
    }
    
    private func setupRoulette () {
        self.rouletteComponent.numberItems = 5
    }
    
    func girar (sender: UIButton) {
        self.rouletteComponent.girar() { (elemento: CircleView) in
            print(elemento)
        }
    }


}
