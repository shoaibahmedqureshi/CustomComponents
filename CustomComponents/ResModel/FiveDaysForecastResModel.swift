//
//  FiveDaysForecastResModel.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/6/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit


class ToDaysForecastResModel: BaseModel {
    
    var base : String = ""
    var mainDetail : Main? = nil
    var clouds :  NSDictionary? = nil
    var cod : NSNumber = 0
    var coord : NSDictionary? = nil
    var dt : NSNumber = 0
    var id : NSNumber = 0
    var name : String = ""
    var sis : NSDictionary? = nil
    var weather : NSDictionary? = nil
    var wind : NSDictionary? = nil
    var main :  NSDictionary? = nil
    {
        willSet(newVal){
            mainDetail  = Main(dictionary:newVal as! Dictionary<String, AnyObject>)
        }
        
    }

}

class FiveDaysForecastResModel: BaseModel {
    
    var mainDetail : Main? = nil
    
    var main :  NSDictionary? = nil
    {
        willSet(newVal){
            mainDetail  = Main(dictionary:newVal as! Dictionary<String, AnyObject>)
        }
        
    }
    
    
}

class Main : BaseModel {
    var temp : Double = 0.0
    var humidity: Double = 0.0
    var pressure: Double = 0.0
    var temp_min: Double = 0.0
    var temp_max: Double = 0.0
    
    required init(dictionary: Dictionary<String, AnyObject>) {
        super.init(dictionary: dictionary)
    }
    
     required init() {
       super.init()
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
}
