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
    @IBOutlet weak var colecaoFilmes: UICollectionView!
    
    var listaDeFilmes:[Filmes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        colecaoFilmes.dataSource = self
        colecaoFilmes.delegate = self
    }
    
    
    func getData(){
        
    
        let urlString = "https://api.themoviedb.org/3/trending/movie/day?api_key=92f48df587a0b620ed4b4a7ecc9b9159"
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(response)
            guard let data = data, error == nil else {return}
            do{
                
                self.todosOsFilmes = try JSONDecoder().decode(APIMovies.self, from: data)
                guard let resultado = self.todosOsFilmes?.results  else {return}
                
            
                for i in 0...resultado.count-1{
                    guard let titulo = resultado[i].title else {return}
                    guard let posterPath = resultado[i].posterPath else {return}
                    guard let rating = resultado[i].voteAverage else {return}
                    guard let overview = resultado[i].overview else {return}
                    let caminhoCompleto = "https://image.tmdb.org/t/p/w500\(posterPath)"
                    let newMovie = Filmes(titulo, caminhoCompleto, rating, overview)
                    self.listaDeFilmes.append(newMovie)
                    print(self.listaDeFilmes[i].titulo)
                    print(self.listaDeFilmes[i].posterPath)
                    }
                 self.colecaoFilmes.reloadData()
              
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
        //celulaFilme.backgroundColor = UIColor.blue
        return celulaFilme
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = listaDeFilmes[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhesFilmes") as! DetalhesViewController
        controller.filmeSelecionado = filme
        self.present(controller, animated: true, completion: nil)
        //print("Clicou em um filme")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 277.5)
    }
    
    
}


import Foundation

// MARK: - APIMovies
struct APIMovies: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let video: Bool
    let voteAverage: Double?
    let overview, releaseDate, title: String?
    let adult: Bool
    let backdropPath: String
    let id: Int
    let genreIDS: [Int]
    let voteCount: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, posterPath: String?
    let popularity: Double
    let mediaType: MediaType
    
    enum CodingKeys: String, CodingKey {
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case title, adult
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case it = "it"
    case ru = "ru"
}
