//
//  JogadoresViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 14/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class JogadoresViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func iniciar() {
        self.performSegue(withIdentifier: "toRoul", sender: self)
    }

}
