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
    
    var tipo: String?
    
    @IBOutlet weak var buttonArregou: UIButton!
    @IBOutlet weak var buttonRespondeu: UIButton!
    @IBOutlet weak var imagem: UIImageView!
    
    @IBOutlet weak var buttonStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelMensagem.text = self.textoLabel
        self.progressView.backgroundColor = .clear
        
        if let t = self.tipo {
            switch t {
            case "Verdade":
                self.progressView.alpha = 0
                self.buttonStart.alpha = 0
                self.imagem.image = #imageLiteral(resourceName: "verdade")
                break;
            case "Desafio":
                self.imagem.alpha = 0
                self.buttonArregou.alpha = 0
                self.buttonRespondeu.alpha = 0
                break;
            case "Interrogação":
                self.imagem.image = #imageLiteral(resourceName: "interrogacao")
                self.progressView.alpha = 0
                self.buttonStart.alpha = 0
                self.buttonRespondeu.setTitle("Verdade", for: .normal)
                self.buttonArregou.setTitle("Desafio", for: .normal)
                break;
            default:break;
            }
        }
        
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: true, completion: completion)
        self.progressView.audio?.stop()
        self.controller?.reload()
    }
    
    @IBOutlet weak var labelMensagem: UILabel!

    @IBOutlet weak var progressView: ProgressView!
    
    @IBAction func handlerStart(_ sender: Any) {
        self.buttonStart.alpha = 0
        self.progressView.startAnimation(withTimer: 10) { 
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    @IBAction func handlerArregou(_ sender: Any) {
        self.progressView.alpha = 1
        self.buttonStart.alpha = 1
        self.buttonArregou.alpha = 0
        self.buttonRespondeu.alpha = 0
        self.labelMensagem.text = "Você pode propor um desafio!"
        self.imagem.alpha = 0
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
    @IBAction func handlerRespondeu(_ sender: Any) {
        if let t = self.tipo {
            switch t {
            case "Verdade":
                self.dismiss(animated: true, completion: nil)
                self.controller?.reload()
                break;
            case "Interrogação":
                self.progressView.alpha = 0
                self.buttonStart.alpha = 0
                self.imagem.image = #imageLiteral(resourceName: "verdade")
                self.buttonArregou.setTitle("Arregou", for: .normal)
                self.buttonArregou.alpha = 1
                self.buttonRespondeu.setTitle("Respondeu", for: .normal)
                self.buttonRespondeu.alpha = 1
                self.labelMensagem.text = "Tem o direito de fazer uma pergunta!"
                break;
            default:break;
            }
        }
    }

    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if self.buttonStart.isFocused {
            self.buttonStart.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            self.buttonStart.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        if self.buttonArregou.isFocused {
            self.buttonArregou.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            self.buttonArregou.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        if self.buttonRespondeu.isFocused {
            self.buttonRespondeu.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            self.buttonRespondeu.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}
