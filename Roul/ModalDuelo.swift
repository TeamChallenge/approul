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
    
    @IBOutlet weak var pickerCacaNiquel: TVPickerView!
    
    var imageJog1 = UIImage()
    var imageJog2 = UIImage()
    var nameJog1 = String()
    var nameJog2 = String()
    
    override func viewDidLoad() {
        self.atribuiImagens()
        
        self.pickerCacaNiquel.focusDelegate = self
        self.pickerCacaNiquel.dataSource = self
        self.pickerCacaNiquel.delegate = self
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
    
    fileprivate var isPickerLoaded: Bool = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isPickerLoaded {
            pickerCacaNiquel.reloadData()
            isPickerLoaded = true
        }
        
    }


    let colors: [UIColor] = [
        .black,
        .darkGray,
        .lightGray,
        .gray,
        .red,
        .green,
        .blue,
        .cyan,
        .yellow,
        .magenta,
        .orange,
        .purple,
        .brown,
        .black,
        .darkGray,
        .lightGray,
        .gray,
        .red,
        .green,
        .blue,
        .cyan,
        .yellow,
        .magenta,
        .orange,
        .purple,
        .brown,
        .black,
        .darkGray,
        .lightGray,
        .gray,
        .red,
        .green,
        .blue,
        .cyan,
        .yellow,
        .magenta,
        .orange,
        .purple,
        .brown,
        .black,
        .darkGray,
        .lightGray,
        .gray,
        .red,
        .green,
        .blue,
        .cyan,
        .yellow,
        .magenta,
        .orange,
        .purple,
        .brown,
        ]

}

extension ModalDuelo: TVPickerViewFocusDelegate {
    
    func pickerView(_ picker: TVPickerView, deepFocusStateChanged isDeepFocus: Bool) {
        
    }
    
}

extension ModalDuelo: TVPickerViewDataSource {
    
    func numberOfViewsInPickerView(_ picker: TVPickerView) -> Int {
        return self.colors.count
    }
    
    func pickerView(_ picker: TVPickerView, viewForIndex idx: Int, reusingView view: UIView?) -> UIView {
        
        var sview = view as? UILabel
        
        if sview == nil {
            sview = UILabel()
            sview!.textColor = .white
            sview!.font = .systemFont(ofSize: 30)
            sview!.textAlignment = .center
        }
        
        sview!.backgroundColor = colors[idx]
        sview!.text = " \(idx)"
        
        return sview!
    }
    
}

extension ModalDuelo: TVPickerViewDelegate {
    
    func pickerView(_ picker: TVPickerView, didChangeToIndex index: Int) {
        
    }
    
}
