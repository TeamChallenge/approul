//
//  TimerProgress.swift
//  Roul
//
//  Created by Thiago Vinhote on 15/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit
import AVFoundation

class ProgressView: UIView {
    
    var audio : AVAudioPlayer? = {
        let a = AudioPlayer.configureAudio(withName: "timer")
        a?.prepareToPlay()
        a?.volume = 1.5
        return a
    }()
    
    var image: UIImageView = {
        let u = UIImageView(image: #imageLiteral(resourceName: "relogio"))
        u.translatesAutoresizingMaskIntoConstraints = false
        u.contentMode = .scaleAspectFill
        return u
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var colorProgress: UIColor = UIColor.colorFromHex(0x674332) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setup()
    }
    
    typealias handlerCompletion = () -> Void
    
    private var progressCircle = CAShapeLayer()
    
    private func setup() {
        self.progressCircle.removeFromSuperlayer()

        let center = CGPoint(x: self.bounds.origin.x + self.frame.width / 4, y: self.bounds.origin.y + self.frame.height / 4)
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: center, size: CGSize(width: self.frame.width * 0.5, height: self.frame.height * 0.5)))

        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = self.colorProgress.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = self.frame.width / 2

        self.layer.addSublayer(progressCircle)

        self.transform = CGAffineTransform(rotationAngle: (3*CGFloat(M_PI)/2))
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        
        self.addSubview(self.image)
        self.image.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.image.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func startAnimation(withTimer timer: TimeInterval, completion: @escaping handlerCompletion) {
        
        self.audio?.play()
        
        self.progressCircle.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = timer
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        progressCircle.add(animation, forKey: "strokeEnd")
        
        
        delay(Int(timer)) {
            self.shake()
            let a = CABasicAnimation(keyPath: "transform.scale")
            a.fromValue = 1
            a.toValue = 1.1
            a.duration = 0.6
            a.repeatCount = 20
            a.autoreverses = true
            self.layer.add(a, forKey: "scale")
            
            delay(4) {
                self.audio?.stop()
                completion()
            }
        }
    }
    
    
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.autoreverses = true
        animation.repeatCount = 20
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0, 5, -5, 10, -10, 20, -20, 20, -20]
        layer.add(animation, forKey: "shake")
    }
}

import AVFoundation

class TimerProgress: UIView {
    
    var audio: AVAudioPlayer? = {
        let a = AudioPlayer.configureAudio(withName: "Magnum_Shots")
        if #available(tvOS 10.0, *) {
            a?.setVolume(0.1, fadeDuration: 0.01)
        }
        return a
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    var colorProgress: UIColor = UIColor.colorFromHex(0x674332) {
        didSet{
            self.setup()
        }
    }
    
    typealias handlerCompletion = () -> Void
    
    private lazy var progress: ProgressView = {
        let progress = ProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let button : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setup() {
        self.addSubview(self.progress)
        self.progress.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.progress.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.progress.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.progress.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.addSubview(self.button)
        self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.button.addTarget(self, action: #selector(self.startAnimation), for: .primaryActionTriggered)
    }
    
    private var timer: TimeInterval = TimeInterval()
    private var completion: handlerCompletion = {}
    
    func set(withTimer time: TimeInterval, completion: @escaping handlerCompletion) {
        self.timer = time
        self.completion = completion
        self.button.alpha = 1
    }
    
    @objc private func startAnimation() {
        self.audio?.play()
        self.progress.startAnimation(withTimer: self.timer, completion: self.completion)
        self.button.alpha = 0
    }
    
    override var preferredFocusedView: UIView? {
        return self.button
    }
    
}

extension TimerProgress: AnimationProtocol {
    
    func animacaoMove(inicial: CGPoint, final: CGPoint, completion: @escaping handlerCompletion) {
        self.layer.add(animacaoMoveCom(pontoInicial: inicial, eFinal: final), forKey: "position")
        delay(1, finish: {
            completion()
        })
    }
    
}
