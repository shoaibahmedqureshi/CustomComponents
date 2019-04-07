//
//  WeatherViewModel.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/6/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

protocol WeatherViewModelDelegate {
    func updateWeatherData(weatherData:ToDaysForecastResModel)
}

class WeatherViewModel : NSObject, RestendDelegate {
        
    var items  : [RestaurantModel] = []
    var delegate : WeatherViewModelDelegate? = nil
    
    
    func getTodaysWeather() {
        let web = WebServiceHandler(apiCallback: self)
        web.getTodaysWeatherByLocation(latitude:25.3767058, longitude:68.3491179)
    }
    
    
    
    func restDidReceiveResponse(baseModel: BaseModel, requestType: String, fromCache: Bool) {
        if baseModel is ToDaysForecastResModel {
            let weatherResModel = baseModel as! ToDaysForecastResModel
            let humidity = weatherResModel.mainDetail?.humidity
            print("humidity : \(humidity)")
            delegate?.updateWeatherData(weatherData:weatherResModel)  
        }
    }
    
    func restDidReceiveError(message: String, requestType: String) {
        
    }
    
    
}

