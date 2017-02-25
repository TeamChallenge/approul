//
//  RouletteView.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit
import AVFoundation

class RouletteView: UIView {
    
    var audio: AVAudioPlayer? = {
        let a = AudioPlayer.configureAudio(withName: "roleta")
        a?.volume = 0.3
        a?.numberOfLoops = -1
        return a
    }()
    
    var jogadores : [Jogador]? {
        didSet{
            if let js = self.jogadores?.count {
                self.numberItems = js
            }
            self.setNeedsDisplay()
        }
    }
    
    var options: [(String, UIImage)]? {
        didSet{
            if let op = self.options?.count {
                self.numberItems = op
            }
            self.setNeedsDisplay()
        }
    }
    
    private var indexCurrent: Int = 0
    private var numberItems: Int = 2
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ 
            if self.isFocused {
//                self.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
//                self.layer.borderWidth = 10
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
            } else {
//                self.layer.borderColor = UIColor.clear.cgColor
//                self.layer.borderWidth = 0
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    fileprivate lazy var backgroundRoulette : Roulette = {
        let roulette = Roulette(frame: self.frame)
        roulette.translatesAutoresizingMaskIntoConstraints = false
        roulette.backgroundColor = UIColor.clear
        return roulette
    }()
    
    private let viewCenter : UIView = {
        let v = UIView()
        v.layer.anchorPoint = CGPoint(x: 0.5, y: 0.7)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backgroundRoulette)
        self.backgroundRoulette.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        self.backgroundRoulette.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backgroundRoulette.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundRoulette.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    private lazy var angle : CGFloat = {
        return CGFloat(2 * M_PI / Double(self.numberItems))
    }()

    var labelGirar: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Girar"
        l.font = UIFont(name: "Western", size: 40)
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.jogadores != nil {
        
            self.layer.cornerRadius = min(rect.width, rect.height) / 2
            guard let jogadores = self.jogadores?.enumerated() else {
                print("sem jogadores")
                return
            }
            print("com jogadores")
            for (i, jogador) in jogadores {
                let circle = CircleView(frame: rect)
                circle.startAngle = CGFloat(angle * CGFloat(i))
                circle.endAngle = CGFloat(angle * CGFloat(i + 1))
                circle.backgroundColor = .clear
                circle.sizeIconImage = 70
                circle.raioIcon = 0.8
                circle.color = i % 2 == 0 ? UIColor.clear : UIColor.clear
                circle.iconImage = jogador.imagem
                circle.isBorder = true
                self.addSubview(circle)
                
    //            let numberLabel = UILabel()
    //            numberLabel.text = jogador.nome
    //            numberLabel.font = UIFont.boldSystemFont(ofSize: 50)
    //            numberLabel.textColor = UIColor.white
    //            numberLabel.backgroundColor = .clear
    //            numberLabel.sizeToFit()
    //            let th = angle * (CGFloat(i) + 0.5)
    ////            numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th - CGFloat(M_PI * 0.5)))
    //            numberLabel.center = CGPoint(x: centerView.x + 205 * CGFloat(cos(th)), y: centerView.y + 205 * CGFloat(sin(th)))
    //            self.addSubview(numberLabel)
            }
            self.backgroundRoulette.viewCenter.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) + self.angle * 0.5)
    //        viewCenter.translatesAutoresizingMaskIntoConstraints = false
    //        viewCenter.backgroundColor = .brown
    //        viewCenter.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) + self.angle * 0.5)
    //        self.addSubview(viewCenter)
    //        
    //        viewCenter.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    //        viewCenter.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    //        viewCenter.heightAnchor.constraint(equalToConstant: rect.height * 0.25).isActive = true
    //        viewCenter.widthAnchor.constraint(equalToConstant: rect.width * 0.05).isActive = true
    //        viewCenter.layer.cornerRadius = (rect.height * 0.2) / 2
        } else if self.options != nil {
            
            self.layer.cornerRadius = min(rect.width, rect.height) / 2
            let centerView = self.convert(self.center, from: self.superview)
            guard let options = self.options?.enumerated() else {
                print("sem opcoes")
                return
            }
            print("com jogadores")
            for (i, opcao) in options {
                let circle = CircleView(frame: rect)
                circle.startAngle = CGFloat(angle * CGFloat(i))
                circle.endAngle = CGFloat(angle * CGFloat(i + 1))
                circle.backgroundColor = .clear
                circle.color = i % 2 == 0 ? UIColor.clear : UIColor.clear
//                circle.iconImage = opcao.1
//                circle.raioIcon = 0.7
//                circle.sizeIconImage = 80
                circle.isBorder = true
                self.addSubview(circle)
  
                let imagaView = UIImageView(image: opcao.1)
                imagaView.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
                imagaView.contentMode = .scaleAspectFit
                let th = angle * (CGFloat(i) + 0.5)
//                imagaView.transform = CGAffineTransform(rotationAngle: CGFloat(th - CGFloat(M_PI * 0.5)))
                imagaView.center = CGPoint(x: centerView.x + 160 * CGFloat(cos(th)), y: centerView.y + 160 * CGFloat(sin(th)))
                self.addSubview(imagaView)
                
//                let numberLabel = UILabel()
//                numberLabel.text = opcao
//                numberLabel.font = UIFont.boldSystemFont(ofSize: 35)
//                numberLabel.textColor = UIColor.brown
//                numberLabel.backgroundColor = .clear
//                numberLabel.sizeToFit()
//                let th = angle * (CGFloat(i) + 0.5)
//                if i > (self.numberItems / 2 - 1) {
//                    numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th + CGFloat(M_PI * 0.5)))
//                } else {
//                    numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th - CGFloat(M_PI * 0.5)))
//                }
//                numberLabel.center = CGPoint(x: centerView.x + 175 * CGFloat(cos(th)), y: centerView.y + 175 * CGFloat(sin(th)))
//                self.addSubview(numberLabel)
                self.setGiro(giro: false)
                self.backgroundRoulette.setupColorsVD()
            }
            self.backgroundRoulette.viewCenter.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) + self.angle * 0.5)
            
        }
        
        self.addSubview(self.labelGirar)
        self.labelGirar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.labelGirar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.labelGirar.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.labelGirar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.backgroundRoulette)
        self.backgroundRoulette.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.backgroundRoulette.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backgroundRoulette.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundRoulette.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.clique))
        self.addGestureRecognizer(gesture)
    }
    
    var clicado: Bool = false
    var isRodando: Bool = false
    
    func setGiro(giro: Bool) {
        if giro {
            self.labelGirar.alpha = 1
        } else {
            self.labelGirar.alpha = 0
        }
    }
    
    func clique() {
        if self.isRodando == true {
            return
        }
        if self.clicado == false {
            self.clicado = true
//            self.layer.borderColor = UIColor(white: 0.8, alpha: 0.5).cgColor
            self.backgroundRoulette.viewCenter.shadowButton()
        } else {
            self.clicado = false
//            self.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            self.backgroundRoulette.viewCenter.shadowRemove()
        }
    }
    
    private enum ModeRand {
        case time
        case angle
    }
    
    private func rand(mode: ModeRand = .angle) -> Int {
        var randon: Int
        switch mode {
        case .time:
            //randon = CGFloat(Double.random(min: 1, max: 2))
            randon = Int.randomInt(min: 1, max: 2)
            break
        case .angle:
            //randon = CGFloat(Double.random(min: 2, max: 12))
            randon = Int.randomInt(min: self.numberItems, max: 100)
            break
        }
        return randon
    }
    
    fileprivate var indexUltimoJogador: Int = 0
    
    private func giroViewCenter (_ numberAngles: Int, _ duration: Int) {
        self.setGiro(giro: false)
        let currentAngle = self.backgroundRoulette.viewCenter.layer.presentation()?.value(forKeyPath: "transform.rotation") as! Double
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = currentAngle
        
        let by = CGFloat(numberAngles) * self.angle
        animation.byValue = by
        animation.duration = CFTimeInterval(duration)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.backgroundRoulette.viewCenter.layer.add(animation, forKey: "Animation")
    }
    
    func girar(withIntensidade intensidade: Int, _ completion: @escaping (_ jogador: Jogador?) -> Void) {
        
        if self.clicado == false || self.isRodando == true {
            return
        }
        
        var valorRand = abs(intensidade) / 10
        let duration = rand(mode: .time)
        
        var i = (valorRand + indexCurrent) % self.numberItems
        
        if i == indexCurrent {
            while true {
                valorRand = (valorRand + 50) / 10
                if valorRand < 0 {
                    valorRand = abs(valorRand + (self.numberItems - 1 + self.indexCurrent) )
                }
                i = (valorRand + indexCurrent) % self.numberItems
                if i != indexCurrent {
                    break
                }
            }
        }
        indexCurrent = i
        
        self.audio?.currentTime = 0
        self.audio?.prepareToPlay()
        self.audio?.play()
        
        self.giroViewCenter(valorRand, duration)
        self.isRodando = true
        
        delay(duration) {
            self.isRodando = false
            let j = self.jogadores?[self.indexCurrent]
            self.indexUltimoJogador = self.indexCurrent
            self.audio?.stop()
            completion(j)
        }
    }
    
    func girarOptions(withIntensidade intensidade: Int, _ completion: @escaping (_ opcao: String) -> Void) {
        
        self.audio?.currentTime = 0
        self.audio?.prepareToPlay()
        self.audio?.play()
        
        let valorRand = abs(intensidade) / 10
        let duration = rand(mode: .time)
        
        let i = (valorRand + indexCurrent) % self.numberItems
        
        indexCurrent = i
        
        self.giroViewCenter(valorRand, duration)
        
        delay(duration) {
            self.audio?.stop()
            completion(self.options![self.indexCurrent].0)
        }
    }
    
}

extension UIView {
    
    internal func animacaoMoveCom(pontoInicial inicial: CGPoint, eFinal final: CGPoint) -> CABasicAnimation {
        let move = CABasicAnimation(keyPath: "position")
        move.duration = 1
        move.fromValue = NSValue(cgPoint: inicial)
        move.toValue = NSValue(cgPoint: final)
        move.isRemovedOnCompletion = false
        move.fillMode = kCAFillModeForwards
        return move
    }
    
}

typealias handlerCompletion = () -> Void

protocol AnimationProtocol {
    
    func animacaoMove(inicial: CGPoint, final: CGPoint, completion: @escaping handlerCompletion)
}

extension RouletteView: AnimationProtocol {
    
    func animacaoMove(inicial: CGPoint, final: CGPoint, completion: @escaping handlerCompletion) {
        self.layer.add(animacaoMoveCom(pontoInicial: inicial, eFinal: final), forKey: "position")
 
        delay(1) {
            completion()
        }
    }
    
}
