//
//  ZomatoResModel.swift
//  ARY MIP
//
//  Created by Shoaib Ahmed on 7/4/17.
//  Copyright © 2017 Rockville Developer. All rights reserved.
//

import UIKit

class ZomatoResModel: BaseModel {
   
    var results_found : NSNumber = 0
    var results_start : NSNumber = 0
    var results_shown : NSNumber = 0
    var restaurant : Restaurant? = nil
    var restaurantList : [Restaurant] = []
    var restaurants:NSArray = NSArray() {
      willSet(newVal){
         
         for obj in newVal {
            
            let restaurant = Restaurant(dictionary: obj as! Dictionary<String,AnyObject>)
            restaurantList.append(restaurant)
            
         }
      }
   }
}

class Restaurant: BaseModel {

   var name : String = ""
   var locationDetails : Location? = nil
   var featured_image : String = ""
   var thumb : String = ""
   var all_reviews_count : Int = 0
   var location :  NSDictionary? = nil
    {
        willSet(newVal){
            locationDetails  = Location(dictionary:newVal as! Dictionary<String, AnyObject>)
        }
        
    }
}

class Location : BaseModel {
   var city : String = ""
}


class UserRating : BaseModel {
   var aggregate_rating : String = ""
}




