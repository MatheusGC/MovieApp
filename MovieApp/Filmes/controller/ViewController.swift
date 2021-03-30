//
//  ViewController.swift
//  testingAPIMovie
//
//  Created by Matheus Golke Cardoso on 26/03/21.
//  Copyright © 2021 Matheus. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    var todosOsFilmes:APIMovies?
    var listaDeFilmes:[Filmes] = []
    
    @IBOutlet weak var colecaoFilmes: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        colecaoFilmes.dataSource = self
        colecaoFilmes.delegate = self
    }
    
    
    func getData(){
    
        let urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=92f48df587a0b620ed4b4a7ecc9b9159&language=pt-BR"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(response)
            guard let data = data, error == nil else {return}
            do{
                
                self.todosOsFilmes = try JSONDecoder().decode(APIMovies.self, from: data)
                guard let resultado = self.todosOsFilmes?.results  else {return}
                
            for i in 0...resultado.count-1{
                    guard let posterPath = resultado[i].posterPath else {return}
                    guard let id = resultado[i].id else {return}
                    let caminhoCompleto = "https://image.tmdb.org/t/p/w500\(posterPath)"
                    let newMovie = Filmes(posterPath: caminhoCompleto, id: id)
                    self.listaDeFilmes.append(newMovie)
                    //print(self.listaDeFilmes[i].titulo)
                    //print(self.listaDeFilmes[i].posterPath)
                    }
                
                DispatchQueue.main.async {
                    self.colecaoFilmes.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
           }
        task.resume()
        }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaDeFilmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaFilme = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaFilme", for: indexPath) as! FilmeCollectionViewCell
        let filme = listaDeFilmes[indexPath.item]
        celulaFilme.recebeImagem(filme: filme)
        return celulaFilme
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = listaDeFilmes[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhesFilmes") as! DetalhesViewController
        controller.filmeSelecionado = filme
        self.present(controller, animated: true, completion: nil)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 277.5)
    }
    
    
}


