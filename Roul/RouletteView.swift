//
//  RouletteView.swift
//  Roul
//
//  Created by Thiago Vinhote on 06/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class RouletteView: UIView {
    
    var jogadores : [Jogador]? {
        didSet{
            if let js = self.jogadores?.count {
                self.numberItems = js
            }
            self.setNeedsDisplay()
        }
    }
    
    var options: [String]? {
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
                self.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
                self.layer.borderWidth = 10
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0
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
        self.backgroundRoulette.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.backgroundRoulette.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backgroundRoulette.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundRoulette.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    private lazy var angle : CGFloat = {
        return CGFloat(2 * M_PI / Double(self.numberItems))
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
                self.addSubview(circle)
                
                let numberLabel = UILabel()
                numberLabel.text = opcao
                numberLabel.font = UIFont.boldSystemFont(ofSize: 35)
                numberLabel.textColor = UIColor.brown
                numberLabel.backgroundColor = .clear
                numberLabel.sizeToFit()
                let th = angle * (CGFloat(i) + 0.5)
                numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(th - CGFloat(M_PI * 0.5)))
                numberLabel.center = CGPoint(x: centerView.x + 160 * CGFloat(cos(th)), y: centerView.y + 160 * CGFloat(sin(th)))
                self.addSubview(numberLabel)
            }
            self.backgroundRoulette.viewCenter.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) + self.angle * 0.5)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.backgroundRoulette)
        self.backgroundRoulette.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.backgroundRoulette.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backgroundRoulette.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundRoulette.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
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
        
        var valorRand = abs(intensidade) / 10
        let duration = rand(mode: .time)
        
        var i = (valorRand + indexCurrent) % self.numberItems
        
        if i == indexCurrent || i == self.indexUltimoJogador {
            while true {
                valorRand = (abs(intensidade) + 30) / 10
                if valorRand < 0 {
                    valorRand = abs(valorRand + (self.numberItems - 1 + self.indexCurrent) )
                }
                i = (valorRand + indexCurrent) % self.numberItems
                if i != indexCurrent && i != self.indexUltimoJogador {
                    break
                }
            }
        }
        indexCurrent = i
        
        self.giroViewCenter(valorRand, duration)
        
        delay(duration) {
            let j = self.jogadores?[self.indexCurrent]
            self.indexUltimoJogador = self.indexCurrent
            completion(j)
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
