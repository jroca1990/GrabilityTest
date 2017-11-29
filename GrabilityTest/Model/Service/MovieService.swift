//
//  MovieService.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

protocol MovieService {
    func loadCategories(success: (_ categoryList: [Category]) -> Void, failure:(_ error: NSError) -> Void)
    func loadPopular(page:Int, success: @escaping(_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void)
    func loadTopRate(page:Int, success: @escaping(_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void)
    func loadUpComming(page:Int, success: @escaping(_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void)
    func loadMovieDetail(movieId:String, success: @escaping (_ movie: Movie) -> Void, failure: @escaping (_ error: NSError) -> Void)
    func loadMovieimages(movieId:String, success: @escaping (_ images: [String]) -> Void, failure: @escaping (_ error: NSError) -> Void)
    func searchMovies(text:String, page:Int, success: @escaping(_ movies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void)
}
