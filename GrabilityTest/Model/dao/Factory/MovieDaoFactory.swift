//
//  MovieDaoFactory.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class MovieDaoFactory: NSObject {
    static let instance = MovieDaoFactory()
    var movieDao : MovieDao?
    
    private override init() {
        movieDao = nil
        super.init()
    }
    
    func movieDaoInstance() -> MovieDao {
        if ((movieDao == nil)) {
            movieDao = MovieDaoImp()
        }
        return movieDao!
    }
}
