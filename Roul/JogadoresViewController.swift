//
//  JogadoresViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 14/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit
import AVFoundation

class ButtonCustom: UIButton {
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            context.nextFocusedView!.layer.shadowOffset = CGSize(width: 0, height: 15)
            context.nextFocusedView!.layer.shadowOpacity = 0.6
            context.nextFocusedView!.layer.shadowRadius = 50
            context.nextFocusedView!.layer.shadowColor = UIColor.black.cgColor
            context.previouslyFocusedView?.layer.shadowOpacity = 0
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
    
}

class JogadoresViewController: UIViewController {
    
    @IBOutlet weak var avataresCollectionView: UICollectionView!
    @IBOutlet weak var gamersSelecionadosCollectionView: UICollectionView!
    @IBOutlet weak var buttonIniciar: ButtonCustom!
    
    var audioPlayer: AVAudioPlayer?
    
    fileprivate var focusGuide = UIFocusGuide()
    var jogadoresAdicionados = [Jogador]()
    var jogadoresParaAdicionar = [Jogador]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avataresCollectionView.backgroundColor = UIColor.clear
        self.gamersSelecionadosCollectionView.backgroundColor = UIColor.clear
        self.avataresCollectionView.allowsMultipleSelection = true
        carregarJogadores()
        self.setupSubviews()
        self.buttonIniciar.backgroundColor = .clear
        
        if let a = AudioPlayer.configureAudio(withName: "Funk_Down") {
            self.audioPlayer = a
            self.audioPlayer?.volume = 0.1
            self.audioPlayer?.numberOfLoops = -1
            self.audioPlayer?.play()
        }
        // Do any additional setup after loading the view.
    }
    
    func carregarJogadores(){
        self.jogadoresParaAdicionar = JogadorStore.singleton.getJogadores()
        avataresCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        guard var nextFocusedView = context.nextFocusedView else { return }
        
        if let superView = nextFocusedView.superview, superView == self.gamersSelecionadosCollectionView  {
            nextFocusedView = superView
        }
        
        switch nextFocusedView {
        case self.buttonIniciar:
            self.focusGuide.preferredFocusedView = self.gamersSelecionadosCollectionView
            break
        case self.gamersSelecionadosCollectionView:
            self.focusGuide.preferredFocusedView = self.buttonIniciar
            break
        default:
            self.focusGuide.preferredFocusedView = nil
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == avataresCollectionView {
//            var gamerSelected = self.jogadoresParaAdicionar.remove(at: indexPath.item)
//            avataresCollectionView.deleteItems(at: [indexPath])
//            self.jogadoresAdicionados.append(gamerSelected)
//
//            if let indexAdicionado = self.jogadoresAdicionados.index(of: gamerSelected) {
//                let index = IndexPath(item: indexAdicionado, section: 0)
//                self.gamersSelecionadosCollectionView.insertItems(at: [index])
//            }

            if let cell = collectionView.cellForItem(at: indexPath) as? AvataresCollectionViewCell, cell.ativo == false {
                cell.ativo = true
                cell.isUserInteractionEnabled = false
            } else {
                return
            }
            
            let gamerSelected = self.jogadoresParaAdicionar[indexPath.item]
            self.jogadoresAdicionados.append(gamerSelected)
            
            if let indexAdicionado = self.jogadoresAdicionados.index(of: gamerSelected) {
                let index = IndexPath(item: indexAdicionado, section: 0)
                self.gamersSelecionadosCollectionView.insertItems(at: [index])
                if let cell = gamersSelecionadosCollectionView.cellForItem(at: indexPath) as? AvataresCollectionViewCell {
                    cell.ativo = true
                } else {
                    return
                }
            }
        }else{
            let gamerSelected = self.jogadoresAdicionados.remove(at: indexPath.item)
            gamersSelecionadosCollectionView.deleteItems(at: [indexPath])
            
            if let indexPath = self.jogadoresParaAdicionar.index(where: { (jogador: Jogador) -> Bool in
                return jogador.nome == gamerSelected.nome
            }) {
                let index = IndexPath(item: indexPath, section: 0)
                if let cell = self.avataresCollectionView.cellForItem(at: index) as? AvataresCollectionViewCell{
                    cell.ativo = false
                    cell.isSelected = false
                    cell.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    fileprivate func setupButtonStart() {
        if self.jogadoresAdicionados.count > 2 {
            self.buttonIniciar.isEnabled = true
        } else {
            self.buttonIniciar.isEnabled = false
        }
    }
    
    @IBAction func iniciar() {
        self.performSegue(withIdentifier: "toRoul", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRoul" {
            if let inst = segue.destination as? HomeViewController {
                inst.jogadores = self.jogadoresAdicionados
            }
        }
    }
}
    
extension JogadoresViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == avataresCollectionView {
            return jogadoresParaAdicionar.count
        }else{
            return jogadoresAdicionados.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == avataresCollectionView {
            let cellAvatares = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAvatares", for: indexPath) as! AvataresCollectionViewCell
            cellAvatares.setupViews(jogador: jogadoresParaAdicionar[indexPath.item])
            cellAvatares.isSound = true
            self.setupButtonStart()
            return cellAvatares
        }else{
            let cellJogadores = collectionView.dequeueReusableCell(withReuseIdentifier: "cellJogadores", for: indexPath) as! AvataresCollectionViewCell
            cellJogadores.setupViews(jogador: (jogadoresAdicionados[indexPath.item]))
            cellJogadores.isSound = false
            self.setupButtonStart()
            return cellJogadores

        }
    }
    
}

extension JogadoresViewController {
    
    fileprivate func setupSubviews() {
        self.view.addLayoutGuide(self.focusGuide)

        self.focusGuide.leftAnchor.constraint(equalTo: self.gamersSelecionadosCollectionView.leftAnchor).isActive = true
        self.focusGuide.topAnchor.constraint(equalTo: self.buttonIniciar.topAnchor).isActive = true
        self.focusGuide.rightAnchor.constraint(equalTo: self.buttonIniciar.leftAnchor, constant: -20).isActive = true
        self.focusGuide.heightAnchor.constraint(equalTo: self.buttonIniciar.heightAnchor).isActive = true
        
    }
    
}
