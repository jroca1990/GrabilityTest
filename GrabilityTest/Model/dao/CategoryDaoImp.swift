//
//  CategoryDaoImp.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import Alamofire

class CategoryDaoImp: CategoryDao {
    func loadCategories(success: (_ categoryList: [Category]) -> Void, failure:(_ error: NSError) -> Void) {
        let categoriesDB = DataController.loadCategories();

        if categoriesDB.count == 0 {
            var categories:[Category] = [Category]()
            let cartegoryPopular = Category(name: "Popular", categoryId: Constants.POPULAR_ID)
            categories.append(cartegoryPopular!)
            
            let cartegoryTop = Category(name: "Top Rated", categoryId: Constants.TOP_RATED_ID)
            categories.append(cartegoryTop!)
            
            let cartegoryUp = Category(name: "Upcoming", categoryId: Constants.UPCOMING_ID)
            categories.append(cartegoryUp!)
            
            for category in categories  {
                DataController.saveCategoryToDB(categoryId: category.categoryId!, categoryName: category.name!)
            }
            
            success(categories)
        } else {
            var categories = [Category]()
            for data in categoriesDB {
                categories.append(Category(name: (data.value(forKey: "name") as? String)!,
                                           categoryId: data.value(forKey: "categoryId") as! String)!)
            }
            success(categories)
        }
       
    }
    
    func loadMoviesFromCategoryJson(url:String, success: @escaping (_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure:@escaping (_ error: NSError) -> Void) {

            Alamofire.request(url).responseJSON { (response) in
                switch response.result {
                case .success(let JSON):
                    if let jsonResult = JSON as? Dictionary<String, AnyObject> {
                        let totalPages = jsonResult["total_pages"] as? Int
                        if let moviesResult = jsonResult["results"] as? Array<Dictionary<String, AnyObject>> {
                            var movies = [Movie]()
                            for movie:Dictionary<String, AnyObject> in moviesResult {
                                let title = movie["title"] as! String
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
