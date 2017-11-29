//
//  MoviesPresenter.swift
//  GrabilityTest
//
//  Created by Jorge on 11/23/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import Foundation

protocol MoviesView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovies(movies: [Movie], totalPages:Int)
}

class MoviesPresenter: NSObject {
    var movieService: MovieService?
    weak fileprivate var moviesView : MoviesView?
    
    func attachView(_ view:MoviesView){
        moviesView = view
    }
    
    func getMovies(category:Category, page:Int){
        movieService = ServiceFactory.instance.moviesServiceInstance()
        self.moviesView?.startLoading()
        switch category.categoryId {
        case Constants.POPULAR_ID?:
            movieService?.loadPopular(page:page, success: { (movies, totalPages) in
                self.moviesView?.setMovies(movies: movies, totalPages: totalPages)
                self.moviesView?.finishLoading()
            }, failure: { (error) in
                self.moviesView?.finishLoading()
            })
            break
        case Constants.TOP_RATED_ID?:
            movieService?.loadTopRate(page:page, success: { (movies, totalPages) in
                self.moviesView?.setMovies(movies: movies, totalPages: totalPages)
                self.moviesView?.finishLoading()
            }, failure: { (error) in
                self.moviesView?.finishLoading()
            })
            break
        case Constants.UPCOMING_ID?:
            movieService?.loadUpComming(page:page, success: { (movies, totalPages) in
                self.moviesView?.setMovies(movies: movies, totalPages: totalPages)
                self.moviesView?.finishLoading()
            }, failure: { (error) in
                self.moviesView?.finishLoading()
            })
            break
        default: break
        }
       
    }
    
    func saveMovies(movies: [Movie], category:Category) {
        for movie in movies {
            DataController.saveMovieToDB(movieId: movie.movieId!, movieTitle: movie.title!, posterPath: movie.poster_path!, categoryId: category.categoryId!, categoryName: category.name!)
        }
    }
}
