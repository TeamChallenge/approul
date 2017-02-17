//
//  ViewController.swift
//  RoulMobile
//
//  Created by Thiago Vinhote on 13/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func enviarAcao() {
        BonjourTCPClient.sharedInstance.servicesCallback = { (services) in
            guard let service = services.first else {
                return print("no services")
            }
            
            print("conectado com: \(service.name)")
            
            BonjourTCPClient.sharedInstance.connectTo(service, callback: {
                BonjourTCPClient.sharedInstance.send(self.input.text!)
            })
        }
    }

}
