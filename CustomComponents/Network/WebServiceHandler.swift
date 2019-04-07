//
//  WebServiceHandler.swift
//  Medcheck v3.0
//
//  Created by Rockville Developer on 4/12/17.
//  Copyright © 2017 Rockville Developer. All rights reserved.
//

//
//  WebServiceHandler.swift
//  MedCheck
//
//  Created by Zeeshan Shakeel on 11/10/15.
//  Copyright © 2015 Rockeville technologies. All rights reserved.
//

import Foundation
import UIKit

//API Request Ids

class WebServiceHandler: NSObject, RestendDelegate {
   
   
    internal func restDidReceiveResponse(baseModel: BaseModel, requestType: String, fromCache: Bool) {
  
    }
   
   internal func restDidReceiveError(message: String, requestType: String) {
      
   }

   
   var delegate: RestendDelegate?
   
   override init(){
      super.init()
   }
   
   init(apiCallback: RestendDelegate?){
      
      super.init()
      
      self.delegate = apiCallback
   }
    

    func searchRestaurantsByLocation(searchParams:RestaurantModel) {
        var header: Dictionary<String,String> = [:]
        header["user-key"] = USER_KEY
        let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"?lat=\(searchParams.lat)&lon=\(searchParams.long))&sort=\(searchParams.sort)&order=\(searchParams.order)" , responseType: ZomatoResModel.self, requestMethod: RequestMethod.GET, headers: header, data: nil as Dictionary<String, AnyObject>?, params:nil)
        
        restClient.getModel(baseURL: ZOMATO_BASE_URL)
      
    }
    
    func getTodaysWeatherByLocation(latitude:Double,longitude:Double) {
        let appId = "appid=\(OPEN_WEATHER_MAP_APP_ID)"
        let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"?lat=\(latitude)&lon=\(longitude)&\(appId)" , responseType: ToDaysForecastResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil as Dictionary<String, AnyObject>?, params:nil)
        
        restClient.getModel(baseURL: WEATHER_TODAY_BASER_URL)
        
    }


   
   
   
//   /*
//    *Care Team APIs
//    */
//   
//   //Not Tested
  
}

