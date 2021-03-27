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


class ViewController: UIViewController, UICollectionViewDataSource{
   
    
    @IBOutlet weak var colecaoFilmes: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        colecaoFilmes.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaFilme = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaFilme", for: indexPath) as! FilmeCollectionViewCell
        celulaFilme.backgroundColor = UIColor.blue
        return celulaFilme
    }
    

    func getData(){
        
    
        let urlString = "https://api.themoviedb.org/3/trending/all/day?api_key=92f48df587a0b620ed4b4a7ecc9b9159"
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(response)
            guard let data = data, error == nil else {return}
            
            var resultado:APIMovies?
            
            do{
                
                resultado = try JSONDecoder().decode(APIMovies.self, from: data)
                
            }catch{
                print(error.localizedDescription)
            }
            
            guard let resultadoFinal = resultado else {return}
            
            print(resultadoFinal.results?.first?.originalTitle)
            
        }
        
        task.resume()
    }
    
    
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct APIMovies: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage, originalTitle, posterPath: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let overview, releaseDate, title: String?
    let id: Int?
    let adult: Bool?
    let popularity: Double?
    let mediaType: MediaType?
    let originalName: String?
    let originCountry: [String]?
    let name, firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview
        case releaseDate = "release_date"
        case title, id, adult, popularity
        case mediaType = "media_type"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case name
        case firstAirDate = "first_air_date"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

