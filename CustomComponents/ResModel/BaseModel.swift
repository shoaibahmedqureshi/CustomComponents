//
//  BaseModel.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/4/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    var dbId: Int64 = 0
    var previousKey: String = ""
    var modelId: String = ""
    var modelDescription: String = ""
    var status: Bool = false
    var message: String = ""
    var errCode: Int = 0
    var requestID: Int = 0
    
    var resCode: Int = 0
    
    var displayMessage: String = ""
    var isError = false
    
    override required init() { }
    
    required init(dictionary: Dictionary<String,AnyObject>) {
        super.init()
        
        for (key, value) in dictionary {
            
            let keyName = key as String
            let keyValue: AnyObject = value
          
            //let mirror = Mirror(reflecting: self)
           // print(mirror.children.flatMap { $0.label })
            if key == "description" {
                if(!(value is NSNull)) {
                    self.modelDescription = (value as! String)
                }
            }
 
            else if (self.responds(to:NSSelectorFromString(key) )) {
                print(".....")
                if(!(value is NSNull)) {
                    self.setValue(keyValue, forKey: keyName)
                }
            }
          }
            
        }
        

    func setValue(value: AnyObject?, forKey key: String) {
        
        if self.previousKey == key {return }
        self.previousKey = key
        if key == "id" || key == "_id" {
            
            self.modelId = (value as! String)
        }
        else if key == "description" {
            
            self.modelDescription = (value as! String)
        }
        else {
            
            if value != nil {
                
                /*
                 do{
                 try super.setValue(value,forKey: key)
                 }
                 catch{
                 
                 print(error)
                 }*/
                
                TryCatchHandling.`try`({ () -> Void in
                    
                    super.setValue(value,forKey: key)
                    
                }, catch: { (exception) -> Void in
                    
                    print("BaseModel->setValue: \(exception?.reason!)")
                    
                }, finally: { () -> Void in
                    
                })
                
            } else {
                
                print("BaseModel->setValue:cannot set nil for key = \(key)")
            }
        }
    }
    
}
