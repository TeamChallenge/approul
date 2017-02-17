//
//  JogadoresViewController.swift
//  Roul
//
//  Created by Thiago Vinhote on 14/02/17.
//  Copyright © 2017 Jerlilson Bezerra da Silva. All rights reserved.
//

import UIKit

class JogadoresViewController: UIViewController {
    @IBOutlet weak var avataresCollectionView: UICollectionView!
    @IBOutlet weak var gamersSelecionadosCollectionView: UICollectionView!
    
    var jogadoresAdicionados = [Jogador]()
    var jogadoresParaAdicionar = [Jogador]()
    
    let avatares = [#imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5"), #imageLiteral(resourceName: "avatar6"), #imageLiteral(resourceName: "avatar7")]
    let nameAvatar = ["Um", "Dois", "Tres", "Quatro", "Cinco", "Seis", "Sete"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avataresCollectionView.backgroundColor = UIColor.clear
        self.gamersSelecionadosCollectionView.backgroundColor = UIColor.clear
        
        carregarJogadores()
        // Do any additional setup after loading the view.
    }
    
    func carregarJogadores(){
        for i in 0...6 {
            let dic = ["nome": nameAvatar[i], "imagem": avatares[i]] as [String : Any]
            let gamer = Jogador(dic: dic) //cria um novo jogador
            self.jogadoresParaAdicionar.append(gamer)
        }
        avataresCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == avataresCollectionView {
            var gamerSelected = self.jogadoresParaAdicionar.remove(at: indexPath.item)
            avataresCollectionView.deleteItems(at: [indexPath])
            self.jogadoresAdicionados.append(gamerSelected)
            
            if let indexAdicionado = self.jogadoresAdicionados.index(of: gamerSelected) {
                let index = IndexPath(item: indexAdicionado, section: 0)
                self.gamersSelecionadosCollectionView.insertItems(at: [index])
            }
        }else{
            var gamerSelected = self.jogadoresAdicionados.remove(at: indexPath.item)
            gamersSelecionadosCollectionView.deleteItems(at: [indexPath])
            self.jogadoresParaAdicionar.append(gamerSelected)
            
            if let indexAdicionado = self.jogadoresParaAdicionar.index(of: gamerSelected) {
                let index = IndexPath(item: indexAdicionado, section: 0)
                self.avataresCollectionView.insertItems(at: [index])
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
            return cellAvatares
        }else{
            let cellJogadores = collectionView.dequeueReusableCell(withReuseIdentifier: "cellJogadores", for: indexPath) as! GamersSelecionadosCollectionViewCell
            cellJogadores.setupViews(jogador: (jogadoresAdicionados[indexPath.item]))
            return cellJogadores

        }
    }
    
}
