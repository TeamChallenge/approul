//
//  GamersSelecionadosCollectionViewCell.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class GamersSelecionadosCollectionViewCell: UICollectionViewCell {
    
    
    var imageAvatar : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var nameAvatar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var imagemOriginal: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageAvatar.adjustsImageWhenAncestorFocused = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.addSubview(imageAvatar)
        self.addSubview(nameAvatar)
        
        //        self.imageAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.imageAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imageAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.imageAvatar.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.imageAvatar.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        
        self.nameAvatar.topAnchor.constraint(equalTo: imageAvatar.bottomAnchor, constant: 5.0).isActive = true
        self.nameAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.nameAvatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.nameAvatar.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.nameAvatar.textColor = UIColor.blue
        self.nameAvatar.textAlignment = NSTextAlignment.center
        
    }
    
    func setupViews(jogador: Jogador){
        //imageAvatar.frame = CGRect(x: Int(self.frame.minX) + 5, y: Int(self.frame.minY) + 5, width: 220, height: 200)
        self.imageAvatar.image = jogador.imagem
        self.nameAvatar.text = jogador.nome
        //addSubview(nameAvatar)
    }
}
