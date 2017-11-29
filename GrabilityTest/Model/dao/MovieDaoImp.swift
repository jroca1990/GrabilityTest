//
//  MovieDaoImp.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import Alamofire

class MovieDaoImp: MovieDao {
    func loadMovieDetailJson(url:String, success: @escaping (Movie) -> Void, failure: @escaping (NSError) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                var title: String? = ""
                var movieId: String? = ""
                var posterPath: String? = ""
                var backdropPath: String? = ""
                var originalTitle: String? = ""
                var homepage: String? = ""
                var overview: String? = ""
                var releaseDate: String? = ""
                
                if let jsonResult = JSON as? Dictionary<String, AnyObject> {
                    if let titleValue = jsonResult["title"] as? String  {
                        title = titleValue
                    }
                    
                    if let movieIdValue = jsonResult["id"] as? NSNumber  {
                        movieId = movieIdValue.stringValue
                    }
                    
                    if let backdropPathValue = jsonResult["poster_path"] as? String  {
                        posterPath = backdropPathValue
                    }
                    
                    if let backdropPathValue = jsonResult["backdrop_path"] as? String  {
                        backdropPath = backdropPathValue
                    }
                    
                    if let originalTitleValue = jsonResult["original_title"] as? String  {
                        originalTitle = originalTitleValue
                    }
                    
                    if let homepageValue = jsonResult["homepage"] as? String  {
                        homepage = homepageValue
                    }
                    
                    if let overviewValue = jsonResult["overview"] as? String  {
                        overview = overviewValue
                    }
                    
                    if let releaseDateValue = jsonResult["release_date"] as? String  {
                        releaseDate = releaseDateValue
                    }
                }
                success(Movie(title: title!, movieId: movieId!, poster_path: posterPath!, backdrop_path: backdropPath!, original_title: originalTitle!, homepage: homepage!, overview: overview!, release_date: releaseDate!)!)
           
            case .failure(let error):
                failure(error as NSError)
                break
            }
        }
    }
    
    func loadMovieImagesJson(url:String, success: @escaping(_ images: [String]) -> Void, failure: @escaping(_ error: NSError) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                if let jsonResult = JSON as? Dictionary<String, AnyObject> {
                    var images:[String] = [String]()
                    let backdrops: [Dictionary<String, Any>] = jsonResult["backdrops"] as! [Dictionary<String, Any>]
                    for backdrop in backdrops {
                        images.append(backdrop["file_path"] as! String)
                    }
                    success(images)
                }
            case .failure(let error):
                failure(error as NSError)
                break
            }
        }
    }

    func searchMoviesJson(url:String, success: @escaping(_ movies: [Movie], _ totalPages:Int) -> Void, failure:@escaping(_ error: NSError) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                if let jsonResult = JSON as? Dictionary<String, AnyObject> {
                        let totalPages = jsonResult["total_pages"] as? Int
                        if let moviesResult = jsonResult["results"] as? Array<Dictionary<String, AnyObject>> {
                            var movies = [Movie]()
                            for movie:Dictionary<String, AnyObject> in moviesResult {
                                let title = movie["original_title"] as! String
                                let movieId = movie["id"] as! NSNumber
                                var poster_path = ""
                                
                                if let value = movie["poster_path"] as? String {
                                    poster_path = value
                                    movies.append(Movie(title:title, movieId: movieId.stringValue, poster_path: poster_path)!)
                                }
                            }
                            success(movies, totalPages!)
                        }
                }
            case .failure(let error):
                failure(error as NSError)
                break
            }
        }
    }

}
