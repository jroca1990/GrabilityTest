//
//  Category.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class Category{
    var name: String?
    var categoryId: String?
    
    init?(name:String, categoryId:String) {
        self.name = name
        self.categoryId = categoryId
    }
}

class CategoryMO : NSManagedObject{
    @NSManaged var name: String?
    @NSManaged var categoryId: String?
}
