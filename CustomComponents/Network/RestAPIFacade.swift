//
//  RestAPIFacade.swift
//
//  Created by Shoaib Ahmed on 5/30/16.
//  Copyright © 2016 Rockville Technologies. All rights reserved.
//

/*
 
 USAGE:
 1. Copy RestAPI folder to target project
 2. Create any Request (POST/PUT) Models anywhere in project extending BaseModel
 3. Create any Response (GET) Models anywhere in project extending BaseModel
 4. Create any sub-models used in Models like JSON Objects or Arrays as Dictionary
 5. Implement RestAPIDelegate in UIViewControllers where required
 6. Create RestAPIFacade objects and call .getModel from event handlers where required
 7. Add libsqlite3.dylib or tb as linked library dependency
 8. Add a bridging header (BridgingHeader.h) and specify as project-name/BridgingHeader.h which has: #include <sqlite3.h>
 
 let facade:RestAPIFacade = RestAPIFacade(delegate: self, requestType: "news", responseType: NewsResponse.self, requestMethod: RequestMethod.GET, headers: nil, data: nil, params: "sessionId=127f3e7ae617e907b43f0c9056ffc80edf0ab2026c8e1e7cff0d5e268c969d51")
 facade.getModel()

 
 
 func restDidReceiveResponse(baseModel: BaseModel, requestType: String, fromCache: Bool) {
 print(baseModel.isError)
 
    if requestType == "news" {
        if !baseModel.isError {
            let newsData: NewsResponse = baseModel as! NewsResponse
            if let someData = newsData.getData() {
                print(someData.count)
                var items:[NewsItem] = someData as [NewsItem]
                let item: NewsItem = items[3]
                print(item.title!)
                print(item.modelDescription)
                print(item.publishDate!)
            }
        } else {
            print("error getting news:"+baseModel.displayMessage)
        }
    }
 }

 
 */

import Foundation
import UIKit


enum RequestMethod: String {
    case NONE = "NONE"
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}


protocol RestendDelegate {
    func restDidReceiveResponse(baseModel:BaseModel, requestType:String, fromCache:Bool)
    func restDidReceiveError(message:String, requestType:String)
}


class RestAPIFacade : NSObject
{
    let CACHE_TABLE: String = "result_cache"
    var urlPart: String
    
    var responseClass : BaseModel.Type
    var requestMethod : RequestMethod?
    var getParams: String?
    var postParams : Dictionary<String,AnyObject>?
    var headerParams : Dictionary<String,String>?
    var isMandatory : Bool = true
    var delegate : RestendDelegate
    var requestType : String
    var resquestID: Int = 0
    
    var methodDictionary: Dictionary<String, RequestMethod>
    var urlDictionary: Dictionary<String, String>
    
    var result: BaseModel
    
    
    init(delegate: RestendDelegate, requestType: String, responseType responseClass: BaseModel.Type, requestMethod: RequestMethod?, headers headerParams: Dictionary<String,String>?, data postParams: Dictionary<String,AnyObject>?, params getParams: String?) {
        
        self.delegate = delegate
        self.requestType = requestType
        self.responseClass = responseClass
        self.requestMethod = requestMethod
        self.postParams = postParams
        self.getParams = getParams
        self.headerParams = headerParams
        
        methodDictionary = Dictionary<String, RequestMethod>()
        methodDictionary["login"] = .GET
        
        urlDictionary = Dictionary<String, String>()
        urlDictionary["login"] = "login"
        
        result = responseClass.init()
        isMandatory = true
        
        if requestMethod == nil {
            if let method = methodDictionary[requestType] {
                self.requestMethod = method
            } else {
                self.requestMethod = RequestMethod.GET
            }
        }
        
        if let urlPart = urlDictionary[requestType] {
            self.urlPart = urlPart
        } else {
            self.urlPart = requestType
        }
        
        if let extraParams = getParams {
            self.urlPart = self.urlPart.appending("?"+extraParams)
        }
        
        let (tables, err) = SwiftData.existingTables()
        if err == nil {
            if tables.count < 1 {
                _ = SwiftData.createTable(table: CACHE_TABLE, withColumnNamesAndTypes: ["request": .StringVal, "response": .DataVal, "timestamp": .DateVal])
                _ = SwiftData.createIndex(name: "RequestIndex", onColumns: ["request"], inTable: CACHE_TABLE, isUnique: true)
            }
        }
    }
    
    func retrieveFromCache(apiEndPoint: String, message: String, ignoreTimeStamp: Bool) -> Bool {
        let (resultSet, err) = SD.executeQuery(sqlStr: "SELECT * FROM "+CACHE_TABLE+" WHERE request = ?", withArgs: [apiEndPoint as AnyObject])
        
        if err == nil {
            for row in resultSet {
                if let timestamp = row["timestamp"]?.asDate() {
                    let interval = 0-timestamp.timeIntervalSinceNow
                    if (interval/60)<10 || ignoreTimeStamp {
                        do {
                            let data = row["response"]?.asData()
//                            let jsonDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//                            self.result.setValuesForKeys( jsonDictionary as! [String : AnyObject])
                           
                          
                            
                            let json:Any? = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                            
                            if json is NSDictionary
                            {
                                self.result = self.responseClass.init(dictionary: json as! Dictionary<String, AnyObject>)
                            }
                            else if json is NSArray
                            {
                                print("its an array")
                               // self.result = self.responseClass.init(dictionary: json as! NSArray)
                            }
                            
                            self.resultDispatchHandler(isError: false, isFromCache: true, statusCode: 201, message: message)
                            
                            return true
                        } catch {
                            self.resultDispatchHandler(isError: true, isFromCache: true, statusCode: 701, message: "Invalid Cache")
                        }
                    }
                }
            }
        }
        
        return false
    }
    
    func getModel (baseURL : String) {
        // Setup the session to make REST GET call.  ATS requires exceptions or HTTPS
       // if  apiEndpoint.conta
        var apiEndpoint: String = ""
        if urlPart.lowercased().range(of:"http") != nil {
           apiEndpoint = urlPart
        }
        else {
         apiEndpoint = baseURL.appending(urlPart)
         
        }
      

        if retrieveFromCache(apiEndPoint: apiEndpoint, message: "timestamp cache", ignoreTimeStamp: false) && !isMandatory{
            return
        }
      

        let session = URLSession.shared
        let url = URL(string: apiEndpoint)!
        
        // Create the request
        var request = URLRequest(url: url as URL)
        request.httpMethod = self.requestMethod?.rawValue

        // Set headers as per call
        if headerParams != nil {
            for (key,value) in headerParams! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        if postParams != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.HTTPBody = JSONSerializer.toJson(self.postParams)
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: postParams!, options: JSONSerialization.WritingOptions())
            } catch {
                if retrieveFromCache(apiEndPoint: apiEndpoint, message: "Post params conversion error", ignoreTimeStamp: true) {
                    return
                }
                self.resultDispatchHandler(isError: true, isFromCache: true, statusCode: 600, message: "Post params conversion error")
                return
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Make the HTTP-REST call and handle it in a completion handler
        session.dataTask(with: request as URLRequest, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in

            if error == nil {
                DispatchQueue.main.async() {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            
                // Make sure we get an OK response
                guard let realResponse = response as? HTTPURLResponse , realResponse.statusCode == 200 else {
                  
                     print("response is \(response)")
                    if response == nil {
                        if self.retrieveFromCache(apiEndPoint: apiEndpoint, message: "Invalid or no response", ignoreTimeStamp: true) {
                            return
                        }
                        self.resultDispatchHandler(isError: true, isFromCache: true, statusCode: 601, message: "Invalid or no response")
                    } else {
                        self.resultDispatchHandler(isError: true, isFromCache: true, statusCode: (response as! HTTPURLResponse).statusCode, message: (response as! HTTPURLResponse).description)
                    }
                
                    return
                }
            
               
                do {
                  
                // let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                  
                    // print("dic is \(jsonDictionary)")

                    
                    let json:Any? = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    print("response: \n \(String(describing: json))")
                    
                    if json is NSDictionary
                    {
                        self.result = self.responseClass.init(dictionary: json as! Dictionary<String, AnyObject>)
                    }
                    else if json is NSArray
                    {
                        print("its an array")
                      //  self.result = self.responseClass.init(dictionary: json as! NSArray)
                    }
 
                    self.resultDispatchHandler(isError: false, isFromCache: false, statusCode: (response as! HTTPURLResponse).statusCode, message: (response as! HTTPURLResponse).description)
                } catch {
                    if self.retrieveFromCache(apiEndPoint: apiEndpoint, message: (response as! HTTPURLResponse).description, ignoreTimeStamp: true) {
                        return
                  }
                    self.resultDispatchHandler(isError: true, isFromCache: true, statusCode: (response as! HTTPURLResponse).statusCode, message: (response as! HTTPURLResponse).description)
                }
            } else {
                if self.retrieveFromCache(apiEndPoint: apiEndpoint, message: error!.localizedDescription, ignoreTimeStamp: true) {
                    return
                }
                self.resultDispatchHandler(isError: true, isFromCache: true, statusCode: 400, message: error!.localizedDescription)
            }
        }).resume()
    }
    
    func resultDispatchHandler(isError: Bool, isFromCache: Bool, statusCode: Int, message: String) {
        
        if isError {
            self.result.isError = isError
            self.result.resCode = statusCode
            self.result.message = message
            self.result.displayMessage = message
            self.delegate.restDidReceiveError(message: message, requestType: self.requestType)
         
        }
        
        DispatchQueue.main.async() {
            self.result.requestID = self.resquestID
            self.delegate.restDidReceiveResponse(baseModel: self.result, requestType: self.requestType, fromCache: isFromCache)
        }
    }
}
