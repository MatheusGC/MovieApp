//
//  DetalhesViewController.swift
//  MovieApp
//
//  Created by Matheus Golke Cardoso on 28/03/21.
//  Copyright © 2021 Matheus. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var imagemDoFilme: UIImageView!
    @IBOutlet weak var labelTituloDoFilme: UILabel!
    @IBOutlet weak var labelRatingDoFilme: UILabel!
    @IBOutlet weak var labelSinopseDoFilme: UILabel!
    
    var filmeSelecionado:Filmes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let filme = filmeSelecionado {
            self.imagemDoFilme.af_setImage(withURL: URL(string: filme.posterPath)!)
            self.labelTituloDoFilme.text = filme.titulo
            self.labelRatingDoFilme.text = ("Rating: \(String(filme.rating))")
            self.labelSinopseDoFilme.text = filme.overview
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
