//
//  ModalDuelo.swift
//  Roul
//
//  Created by Renata da Silva Nunes on 09/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class ModalDuelo: UIViewController {
    
    @IBOutlet weak var viewModal: UIView!
    @IBOutlet weak var imgDesafiador: UIImageView!
    @IBOutlet weak var imgDesafiado: UIImageView!
    @IBOutlet weak var nameDesafiador: UILabel!
    @IBOutlet weak var nameDesafiado: UILabel!
    @IBOutlet weak var done: UIButton!
    
    var imageJog1 = UIImage()
    var imageJog2 = UIImage()
    var nameJog1 = String()
    var nameJog2 = String()
    
    override func viewDidLoad() {
        self.atribuiImagens()
    }
    
    func openModal() {
        self.viewModal.center = self.view.center
        self.viewModal.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        self.viewModal.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.viewModal.alpha = 1
            self.viewModal.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func closeModal() {
//        self.viewModal.alpha = 1
        self.dismiss(animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.viewModal.alpha = 0
            self.viewModal.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func atribuiImagens(){
        self.imgDesafiador.image = self.imageJog1
        self.imgDesafiado.image = self.imageJog2
        self.nameDesafiador.text = self.nameJog1
        self.nameDesafiado.text = self.nameJog2
    }
    
    @IBAction func handleDone(_ sender: Any) {
        self.closeModal()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
