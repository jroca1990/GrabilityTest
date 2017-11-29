//
//  ServiceFactory.swift
//  GrabilityTest
//
//  Created by Jorge on 11/22/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class ServiceFactory: NSObject {
    static let instance = ServiceFactory()
    var restaurantService : MovieService?
    
    private override init() {
        restaurantService = nil
        super.init()
    }
    
    func moviesServiceInstance() -> MovieService {
        if ((restaurantService == nil)) {
            restaurantService = TheMoviedbService()
        }
        return restaurantService!
    }
}
