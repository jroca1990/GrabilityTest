//
//  movieSearchPresenter.swift
//  GrabilityTest
//
//  Created by Jorge on 11/29/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

protocol MoviesSearchView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovies(movies: [Movie], totalPages:Int)
}

class MovieSearchPresenter: NSObject {
    var movieService: MovieService?
    weak fileprivate var moviesView : MoviesSearchView?
    
    func attachView(_ view:MoviesSearchView){
        moviesView = view
    }
    
    func searchMovies(text:String, page:Int){
        movieService = ServiceFactory.instance.moviesServiceInstance()
        self.moviesView?.startLoading()
        movieService?.searchMovies(text: text, page: page, success: { (movies, totalPages) in
            self.moviesView?.setMovies(movies: movies, totalPages:totalPages)
            self.moviesView?.finishLoading()
        }, failure: { (error) in
            self.moviesView?.finishLoading()
        })
    }
}
