//
//  DetalhesViewController.swift
//  MovieApp
//
//  Created by Matheus Golke Cardoso on 28/03/21.
//  Copyright © 2021 Matheus. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    
    @IBOutlet weak var imagemDoFilme: UIImageView?
    @IBOutlet weak var labelTituloDoFilme: UILabel?
    @IBOutlet weak var labelRatingDoFilme: UILabel?
    @IBOutlet weak var labelSinopseDoFilme: UILabel?
    
    var filmeSelecionado:Filmes?
    var todosOsDetalhes:DetalhesFilmes?
    var listaDeDetalhes:[Detalhes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let filme = filmeSelecionado else {return}
        getDataDetalhes(filme: filme)
    }
            
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func getDataDetalhes(filme:Filmes){

        let urlDetalhes = "https://api.themoviedb.org/3/movie/\(filme.id)?api_key=92f48df587a0b620ed4b4a7ecc9b9159&language=pt-BR"
        guard let finalUrlDetalhes = URL(string: urlDetalhes) else {return}


        let taskDetalhes = URLSession.shared.dataTask(with: finalUrlDetalhes) { (data, response, error) in
            guard let data = data, error == nil else {return}

            do{
                self.todosOsDetalhes = try JSONDecoder().decode(DetalhesFilmes.self, from: data)
                guard let posterPath = self.todosOsDetalhes?.posterPath else {return}
                guard let titulo = self.todosOsDetalhes?.title else {return}
                guard let rating = self.todosOsDetalhes?.voteAverage else {return}
                guard let overview = self.todosOsDetalhes?.overview else {return}
                let caminhoCompleto = "https://image.tmdb.org/t/p/w500\(posterPath)"
                let detalheAtual = Detalhes(posterPath: caminhoCompleto, titulo: titulo, rating: rating, overview: overview)
                self.listaDeDetalhes.append(detalheAtual)
                //print(self.listaDeDetalhes[0].titulo)
                DispatchQueue.main.async {
                    for resultadosDaLista in self.listaDeDetalhes{
                        guard let url = URL(string: resultadosDaLista.posterPath) else {return}
                        if self.imagemDoFilme != nil{
                            self.imagemDoFilme!.af_setImage(withURL: url)
                        }
                        if self.labelTituloDoFilme != nil{
                            self.labelTituloDoFilme!.text = resultadosDaLista.titulo
                        }
                        
                        if self.labelRatingDoFilme != nil {
                            self.labelRatingDoFilme!.text = String("Rating: \(resultadosDaLista.rating)")
                        }
                        
                        if self.labelSinopseDoFilme != nil{
                            self.labelSinopseDoFilme!.text = resultadosDaLista.overview
                        }
                        
                        }

                }
            }catch{
                print(error)
            }
}

        taskDetalhes.resume()
}
}
