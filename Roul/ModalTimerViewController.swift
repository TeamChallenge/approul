//
//  ModalTimerViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 23/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class ModalTimerViewController: UIViewController {

    weak var controller: HomeViewController?
    var textoLabel: String?
    
    @IBOutlet weak var buttonStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelMensagem.text = self.textoLabel
        self.progressView.backgroundColor = .clear
        
    }
    @IBOutlet weak var labelMensagem: UILabel!

    @IBOutlet weak var progressView: ProgressView!
    
    @IBAction func handlerStart(_ sender: Any) {
        self.buttonStart.alpha = 0
        self.progressView.startAnimation(withTimer: 10) { 
            self.dismiss(animated: true, completion: nil)
            self.controller?.reload()
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if self.buttonStart.isFocused {
            self.buttonStart.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            self.buttonStart.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}
