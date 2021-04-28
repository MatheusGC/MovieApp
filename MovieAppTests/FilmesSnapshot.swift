//
//  FilmesSnapshot.swift
//  MovieAppTests
//
//  Created by Matheus Golke Cardoso on 28/04/21.
//  Copyright © 2021 Matheus. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import MovieApp

class FilmesSnapchot: QuickSpec {
    
    override func spec() {

        describe("ViewController"){

            var view: ViewController!
            
            beforeEach {
                view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "controller") as! ViewController
                _ = view.view
            }
            
            //primeiramente utilizar somente o recordSnapchot() e depois somente o snapshot()
            it("ViewController") {
                //expect(view) == recordSnapshot()
                //expect(view) == snapshot()
            }
        }
    }
}
