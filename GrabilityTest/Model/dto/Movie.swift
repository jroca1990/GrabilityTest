//
//  Movie.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class Movie{
    var title: String?
    var movieId: String?
    var poster_path: String?
    var backdrop_path: String?
    var original_title: String?
    var homepage: String?
    var overview: String?
    var release_date: String?
    
    init?(title:String, movieId:String, poster_path:String) {
        self.title = title
        self.movieId = movieId
        self.poster_path = poster_path
    }
    
    init?(title:String, movieId:String, poster_path:String, backdrop_path:String, original_title:String, homepage:String, overview:String, release_date:String) {
        self.title = title
        self.movieId = movieId
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.original_title = original_title
        self.homepage = homepage
        self.overview = overview
        self.release_date = release_date
    }
}

class MovieMO : NSManagedObject{
    @NSManaged var title:String
    @NSManaged var movieId:String
    @NSManaged var posterPath:String
    @NSManaged var category : CategoryMO?
}

