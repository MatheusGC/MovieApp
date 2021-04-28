//
//  MovieAppSnapShot.swift
//  MovieAppTests
//
//  Created by Matheus Golke Cardoso on 26/04/21.
//  Copyright © 2021 Matheus. All rights reserved.
//
//
//
import FBSnapshotTestCase
@testable import MovieApp

class MovieAppSnapShot: FBSnapshotTestCase {

    var sut: ViewController!

    override func setUp() {
        super.setUp()
        //sut = ViewController()
        //_ = sut.view
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "controller") as! ViewController
        //self.recordMode = true
    }

    override func tearDown() {
        super.tearDown()
        //sut = nil
    }

    func testExample() {
        //FBSnapshotVerifyView(sut.view)
        //FBSnapshotVerifyViewController(sut)
        
        sut.getData()
        sleep(10)
        FBSnapshotVerifyView(sut.view)
    }

}
