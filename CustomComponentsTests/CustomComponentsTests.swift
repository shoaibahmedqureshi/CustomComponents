//
//  CustomComponentsTests.swift
//  CustomComponentsTests
//
//  Created by Shoaib Ahmed Qureshi on 4/3/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import XCTest
@testable import CustomComponents

class CustomComponentsTests: XCTestCase,RestendDelegate  {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherAPI() {
        let appId = "appid=\(OPEN_WEATHER_MAP_APP_ID)"
        let restClient = RestAPIFacade(delegate: self as RestendDelegate, requestType:"?lat=25.3767058&lon=68.3491179&\(appId)" , responseType: ToDaysForecastResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil as Dictionary<String, AnyObject>?, params:nil)
        restClient.getModel(baseURL: WEATHER_TODAY_BASER_URL)
        
    }

    func testZomatoAPI() {
        var header: Dictionary<String,String> = [:]
        header["user-key"] = USER_KEY
        let restClient = RestAPIFacade(delegate: self, requestType:"?lat=25.3767058&lon=68.3491179&&sort=rating&order=desc" , responseType: ZomatoResModel.self, requestMethod: RequestMethod.GET, headers: header, data: nil as Dictionary<String, AnyObject>?, params:nil)
        
        restClient.getModel(baseURL: ZOMATO_BASE_URL)
        
    }
    
    func restDidReceiveResponse(baseModel: BaseModel, requestType: String, fromCache: Bool) {
        if baseModel is ToDaysForecastResModel {
            let model = baseModel as! ToDaysForecastResModel
            XCTAssertEqual(200, model.cod)
        }
        
        else if baseModel is ZomatoResModel {
            let model = baseModel as! ZomatoResModel
            XCTAssert(Int(truncating: model.results_found) > 200)
        }
    }
    
    func restDidReceiveError(message: String, requestType: String) {
        
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
