//
//  Filmes.swift
//  MovieApp
//
//  Created by Matheus Golke Cardoso on 27/03/21.
//  Copyright © 2021 Matheus. All rights reserved.
//

import UIKit

class Filmes: NSObject {
    
    var titulo:String
    var posterPath:String
    
    init(_ titulo:String, _ posterPath:String) {
        self.titulo = titulo
        self.posterPath = posterPath
    }
    
    
}
