//
//  DataController.swift
//  GrabilityTest
//
//  Created by Jorge on 11/23/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    static func saveCategoryToDB(categoryId:String, categoryName:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Categories", into: context) as! CategoryMO
        entity.categoryId = categoryId
        entity.name = categoryName
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func saveMovieToDB(movieId:String, movieTitle:String,  posterPath:String, categoryId:String, categoryName:String) {
        let movie = DataController.loadMovieById(movieId: movieId)
        if  movie.count == 0{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let category = DataController.loadCategoryById(categoryId: categoryId)
            let movie = NSEntityDescription.insertNewObject(forEntityName: "Movies", into: context) as! MovieMO
            category.categoryId = categoryId
            category.name = categoryName
            
            movie.movieId = movieId
            movie.title = movieTitle
            movie.category = category
            movie.posterPath = posterPath
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    static func loadMoviesFromCategory (categoryId: String) -> [MovieMO] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let category = DataController.loadCategoryById(categoryId: categoryId)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "category == %@", category)

        do {
            let result = try context.fetch(request)
            return result as! [MovieMO];
        } catch {
            print("Failed")
        }
        return []
    }
    
    static func loadCategoryById(categoryId: String) -> CategoryMO {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "categoryId == %@", categoryId)
        
        do {
            let result = try context.fetch(request)
            return result[0] as! CategoryMO
        } catch {
            print("Failed")
        }
        
        return CategoryMO()
    }
    
    static func loadMovieById(movieId: String) -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "movieId == %@", movieId)
        
        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
        } catch {
            print("Failed")
        }
        
        return []
    }
    
    static func loadCategories() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
        } catch {
            print("Failed")
        }
        return []
    }
}
