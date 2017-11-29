//
//  CategoryDao.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

protocol CategoryDao {
    func loadCategories(success: (_ categoryList: [Category]) -> Void, failure:(_ error: NSError) -> Void)
    func loadMoviesFromCategoryJson(url:String, success: @escaping (_ popularMovies: [Movie], _ totalPages:Int) -> Void, failure: @escaping(_ error: NSError) -> Void)
}
