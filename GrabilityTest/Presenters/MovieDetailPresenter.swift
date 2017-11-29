//
//  MovieDetailPresenter.swift
//  GrabilityTest
//
//  Created by Jorge on 11/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

protocol MovieDetailView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovieDetails(movie: Movie)
    func setMovieImages(images: [String])
}

class MovieDetailPresenter: NSObject {
    var movieService: MovieService?
    weak fileprivate var moviesView : MovieDetailView?

    func attachView(_ view:MovieDetailView){
        moviesView = view
    }
    
    func getMovieDetail(movie:Movie){
        movieService = ServiceFactory.instance.moviesServiceInstance()
        self.moviesView?.startLoading()

        movieService?.loadMovieDetail(movieId: movie.movieId!, success: { (movie) in
            self.moviesView?.finishLoading()
            self.moviesView?.setMovieDetails(movie: movie)
        }, failure: { (error) in
            self.moviesView?.finishLoading()
        })
        
        movieService?.loadMovieimages(movieId: movie.movieId!, success: { (images) in
            self.moviesView?.setMovieImages(images: images)
        }, failure: { (error) in

        })
    }
}
