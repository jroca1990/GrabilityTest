//
//  TheMoviedbService.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import Reachability

class TheMoviedbService: MovieService {
    var categoryDao:CategoryDao?
    var movieDao:MovieDao?

    func loadCategories(success: (_ categoryList: [Category]) -> Void, failure:(_ error: NSError) -> Void) {
        categoryDao = CategoryDaoFactory.instance.categoryDaoInstance()
        categoryDao?.loadCategories(success: { (categoryList) in
            success(categoryList)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func loadPopular(page:Int, success: @escaping (_ popularMovies:[Movie], _ totalPages:Int) -> Void, failure:@escaping (_ error: NSError) -> Void) {
        self.loadCategoryMovies(page: page, categoryName: "popular", categoryID: Constants.POPULAR_ID, success: { (movies, totalPages) in
            success(movies, totalPages)
        }) { (error) in
            failure(error)
        }
    }
    
    func loadTopRate(page:Int, success: @escaping (_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping (_ error: NSError) -> Void) {
        self.loadCategoryMovies(page: page, categoryName: "top_rated", categoryID: Constants.TOP_RATED_ID, success: { (movies, totalPages) in
            success(movies, totalPages)
        }) { (error) in
            failure(error)
        }
    }
    
    func loadUpComming(page:Int, success: @escaping (_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping (_ error: NSError) -> Void) {
        self.loadCategoryMovies(page: page, categoryName: "upcoming", categoryID: Constants.UPCOMING_ID, success: { (movies, totalPages) in
            success(movies, totalPages)
        }) { (error) in
            failure(error)
        }
    }
    
    func loadCategoryMovies(page:Int, categoryName:String, categoryID:String, success: @escaping (_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping (_ error: NSError) -> Void) {
        
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            self.categoryDao = CategoryDaoFactory.instance.categoryDaoInstance()
            let url = Constants.HOST_MOVIEDB + "/movie/" + categoryName + "?api_key=" + Constants.API_KEY + "&page=" + String(page)
            self.categoryDao?.loadMoviesFromCategoryJson(url: url, success: { (movies, totalPages) in
                success(movies, totalPages)
            }, failure: { (error) in
                failure(error)
            })
        }
        
        reachability.whenUnreachable = { _ in
            let moviesDB = DataController.loadMoviesFromCategory(categoryId: categoryID);
            var movies = [Movie]()
            
            for movie:MovieMO in moviesDB {
                movies.append(Movie(title:movie.title, movieId: movie.movieId, poster_path: movie.posterPath)!)
            }
            success(movies, 0)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func loadMovieDetail(movieId: String, success: @escaping (Movie) -> Void, failure: @escaping (NSError) -> Void) {
        movieDao = MovieDaoFactory.instance.movieDaoInstance()
        let url = Constants.HOST_MOVIEDB + "/movie/" + movieId + "?api_key=" + Constants.API_KEY

        movieDao?.loadMovieDetailJson(url: url, success: { (movie) in
            success(movie)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func loadMovieimages(movieId:String, success: @escaping (_ images: [String]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        movieDao = MovieDaoFactory.instance.movieDaoInstance()
        let url = "https://api.themoviedb.org/3/movie/" + movieId + "/images?api_key=" + Constants.API_KEY

        movieDao?.loadMovieImagesJson(url: url, success: { (images) in
            success(images)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func searchMovies(text:String, page:Int, success: @escaping(_ movies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void) {
        movieDao = MovieDaoFactory.instance.movieDaoInstance()
        let url = "https://api.themoviedb.org/3/search/movie?api_key=" + Constants.API_KEY + "&query=" + text + "&page=" + String(page)
        movieDao?.searchMoviesJson(url: url, success: { (movies, totalPages) in
            success(movies, totalPages)
        }, failure: { (error) in
            failure(error)
        })
    }
}
