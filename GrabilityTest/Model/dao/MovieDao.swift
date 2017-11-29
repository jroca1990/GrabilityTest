//
//  MovieDao.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

protocol MovieDao {
    func loadMovieDetailJson(url:String, success: @escaping(_ movie: Movie) -> Void, failure: @escaping(_ error: NSError) -> Void)
    func loadMovieImagesJson(url:String, success: @escaping(_ images: [String]) -> Void, failure: @escaping(_ error: NSError) -> Void)
    func searchMoviesJson(url:String, success: @escaping(_ movies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void)
}
