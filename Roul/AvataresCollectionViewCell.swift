//
//  AvataresCollectionViewCell.swift
//  Roul
//
//  Created by Jerlilson Bezerra da Silva on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit
import AVFoundation

class AvataresCollectionViewCell: UICollectionViewCell {
    
    static let imageCoringa : UIImage = #imageLiteral(resourceName: "caveira300")
    
    var audio : AVAudioPlayer? = {
        let a = AudioPlayer.configureAudio(withName: "tiroSelecionado")
        a?.volume = 0.5
        return a
    }()
    
    weak var imagemOriginal: UIImage?
    var nomeOriginal: String?
    
    fileprivate var imageBackground : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "bg_avatar")
        image.shadowButton()
        return image
    }()
    
    var imageAvatar : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.image = #imageLiteral(resourceName: "caveira300")
        return image
    }()
    
    var nameAvatar: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Western", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            self.setupSelected()
        }
    }
    
    var isSound: Bool = false
    
    fileprivate func setupSelected() {
        if self.ativo {
            return
        }
        if self.isSelected {
            self.imageAvatar.image = AvataresCollectionViewCell.imageCoringa
            self.imageAvatar.contentMode = .scaleAspectFit
            self.nameAvatar.text = "Procurado"
            if self.isSound {
                audio?.stop()
                audio?.play()
            }
        } else {
            self.imageAvatar.image = self.imagemOriginal
            self.nameAvatar.text = self.nomeOriginal
        }
    }
    
    var ativo: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageAvatar.adjustsImageWhenAncestorFocused = true
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.addSubview(self.imageBackground)
        self.addSubview(imageAvatar)
        self.addSubview(nameAvatar)
        
        self.imageBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageBackground.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageBackground.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
//        self.imageAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.imageAvatar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        self.imageAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.imageAvatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.imageAvatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        self.imageAvatar.layer.cornerRadius = 90
//        self.imageAvatar.layer.borderWidth = 1.0
//        self.imageAvatar.layer.borderColor = UIColor.black.cgColor
        
        self.nameAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        self.nameAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.nameAvatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.nameAvatar.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.nameAvatar.textColor = UIColor.brown
        self.nameAvatar.textAlignment = NSTextAlignment.center
        
        
    }
    
    func setupViews(jogador: Jogador){
        //imageAvatar.frame = CGRect(x: Int(self.frame.minX) + 5, y: Int(self.frame.minY) + 5, width: 220, height: 200)
        self.imageAvatar.image = jogador.imagem
        self.imagemOriginal = jogador.imagem
        self.nameAvatar.text = jogador.nome
        self.nomeOriginal = jogador.nome
        //addSubview(nameAvatar)
    }
}
