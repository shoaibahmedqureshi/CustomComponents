//
//  RestaurantModel.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/4/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

class RestaurantModel: BaseModel {
    var name: String = ""
    var imageURL: String = ""
    var type: String = ""
    var location: String = ""
    var rating: Float = 0

    
    var lat : Float = 0.0
    var long : Float = 0.0
    var sort : String = ""
    var order : String = ""
}
