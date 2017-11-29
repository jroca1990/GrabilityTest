//
//  CategoryDaoFactory.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class CategoryDaoFactory: NSObject {
    static let instance = CategoryDaoFactory()
    var categoryDao : CategoryDao?
    
    private override init() {
        categoryDao = nil
        super.init()
    }
    
    func categoryDaoInstance() -> CategoryDao {
        if ((categoryDao == nil)) {
            categoryDao = CategoryDaoImp()
        }
        return categoryDao!
    }
}
