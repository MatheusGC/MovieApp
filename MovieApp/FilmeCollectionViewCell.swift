//
//  FilmeCollectionViewCell.swift
//  MovieApp
//
//  Created by Matheus Golke Cardoso on 27/03/21.
//  Copyright © 2021 Matheus. All rights reserved.
//

import UIKit

class FilmeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagemFilme: UIImageView!
    
    func recebeImagem(filme:Filmes){

        guard let urlImagem = URL(string: filme.posterPath) else {return}

        imagemFilme.af_setImage(withURL: urlImagem)
    }

}
