//
//  DetalhesViewControllerTests.swift
//  MovieAppTests
//
//  Created by Matheus Golke Cardoso on 27/04/21.
//  Copyright © 2021 Matheus. All rights reserved.
//

import XCTest
@testable import MovieApp

class DetalhesViewControllerTests: XCTestCase {
    
    
    var detalhesViewController: DetalhesViewController!
    let filme = Filmes(posterPath: "https://image.tmdb.org/t/p/w500/inNN466SKHNjbGmpfhfsaPQNleS.jpg", id: 791373)
    

    override func setUp() {
        super.setUp()
        detalhesViewController = DetalhesViewController()
        detalhesViewController.getDataDetalhes(filme: filme)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeveRetornarRating(){
        
        guard let rating = detalhesViewController.listaDeDetalhes.first?.rating else {return}

        XCTAssertEqual(rating, 8.5)


    }
    
    func testDeveRetornarOverview(){


        guard let overview = detalhesViewController.listaDeDetalhes.first?.overview else {return}

        XCTAssertEqual(overview, "Determinado a garantir que o sacrifício final do Superman não foi em vão, Bruce Wayne alinha forças com Diana Prince com planos de recrutar uma equipe de metahumanos para proteger o mundo de uma ameaça de proporções catastróficas que se aproxima.")

    }
    
    func testDeveRetornarTitulo(){
        guard let titulo = detalhesViewController.listaDeDetalhes.first?.titulo else {return}
        XCTAssertEqual(titulo, "Liga da Justiça de Zack Snyder")
    }
    
    func testVerificaSeFilmePassadoPorParametroEFilmeSelecionado(){
        
        guard let filmeSelec = detalhesViewController.filmeSelecionado else {return}
        XCTAssertEqual(filmeSelec, filme)
    }
    
    func testViewDidLoad(){
        detalhesViewController.viewDidLoad()
    }
    
        
    }
    
    

