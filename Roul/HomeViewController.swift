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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRoulette()
    }
    
    private func setupRoulette () {
        self.rouletteComponent.numberItems = 15
    }


}
