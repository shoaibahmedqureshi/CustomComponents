//
//  RestaurantsViewModel.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/6/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import Foundation

protocol RestaurantViewModelDelegate {
    func updateRestuarntData(restaurantList:[Restaurant])
}

class RestaurantViewModel : NSObject, RestendDelegate {
 
    
    var items  : [RestaurantModel] = []
    var delegate : RestaurantViewModelDelegate? = nil
    

    func getRestaurants() {
        let web = WebServiceHandler(apiCallback: self)
        let searchParams = RestaurantModel.init()
        searchParams.lat = 25.3767058
        searchParams.long = 68.3491179
        searchParams.sort = "rating"
        searchParams.order = "desc"
        web.searchRestaurantsByLocation(searchParams:searchParams)
    }
    
    
    
    func restDidReceiveResponse(baseModel: BaseModel, requestType: String, fromCache: Bool) {
        if baseModel is ZomatoResModel {
            let zomatoResModel = baseModel as! ZomatoResModel
            let restaurants = zomatoResModel.restaurantList
            delegate?.updateRestuarntData(restaurantList:restaurants)
        }
    }
    
    func restDidReceiveError(message: String, requestType: String) {
        
    }
    
    
}
