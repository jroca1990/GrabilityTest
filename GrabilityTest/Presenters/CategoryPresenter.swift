//
//  CategoryPresenter.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import Foundation

protocol CategoriesView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setCategories(categories: [Category])
}

class CategoryPresenter: NSObject {
    var movieService: MovieService?
    weak fileprivate var categoriesView : CategoriesView?

    func attachView(_ view:CategoriesView){
        categoriesView = view
    }
    
    func getCategories(){
        categoriesView?.startLoading()
        movieService = ServiceFactory.instance.moviesServiceInstance()
        movieService?.loadCategories(success: { (categories) in
            categoriesView?.setCategories(categories: categories)
            categoriesView?.finishLoading()
        }, failure: { (error) in
            categoriesView?.finishLoading()
        })
    }
}
