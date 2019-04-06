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
        let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"?lat=\(searchParams.lat)&lon=\(searchParams.lat))&sort=\(searchParams.sort)&order=\(searchParams.order)" , responseType: ZomatoResModel.self, requestMethod: RequestMethod.GET, headers: header, data: nil as Dictionary<String, AnyObject>?, params:nil)
        
        restClient.getModel(baseURL: ZOMATO_BASE_URL)
      
    }

   
   
//   func getAllVideos(fetchSize:Int,type:String) {
//      
//         var params: Dictionary<String,String> = [:]
//         params["fetchsize"] = String(fetchSize)
//         params["type"] = type
//         params["sortas"] = "1"
//         params["sortBy"] = "asc"
//         params["startIndex"] = "0"
//      
//         let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"content/getHomeContentByType" , responseType: HomeContentResModel.self, requestMethod: RequestMethod.POST, headers: nil, data: params as Dictionary<String, AnyObject>?, params:nil)
//         
//         
//         
//         restClient.getModel()
//      
//      
//   }
//   
//   
//
//   
//   func getRecentlyPlayedSongs() {
//      var params: Dictionary<String,String> = [:]
//      params["sortas"] = "1"
//      params["sortBy"] = "asc"
//      params["startIndex"] = "0"
//      
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"secure/playlist/getRecentlyPlayed" , responseType: HomeContentResModel.self, requestMethod: RequestMethod.POST, headers: nil, data: params as Dictionary<String, AnyObject>?, params:nil)
//      
//      
//      
//      restClient.getModel()
//   }
//   
//   func getAllBanners(fetchSize:Int) {
//      
//      var params: Dictionary<String,String> = [:]
//      params["fetchSize"] = String(fetchSize)
//      params["sortBy"] = "1"
//      params["sortBy"] = "asc"
//      params["startIndex"] = "0"
//      
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"banner/getAllBanner" , responseType: BannerResModel.self, requestMethod: RequestMethod.POST, headers: nil, data: params as Dictionary<String, AnyObject>?, params:nil)
//      
//      
//      
//      restClient.getModel()
//      
//      
//   }
//   
//   func getHomeContent(maxResults:Int,pageToken:String) {
//      
//       let maxResults = "maxResults=\(maxResults)"
//       let pageToken = "pageToken=\(pageToken)"
//       let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"?order=date&\(maxResults)&channelId=UCkvPHvcNlWzHEu_z5RKAeEA&\(pageToken)&key=AIzaSyBv-ZhhhyQx8EvHIGZGtA5I6QMkxMmA57M&part=snippet&type=video" , responseType: YoutubeHomeResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil , params:nil)
//      
//      restClient.getModel()
//      
//   }
//   
//   func getPopularContent(maxResults:Int,pageToken:String) {
//      let maxResults = "maxResults=\(maxResults)"
//      let pageToken = "pageToken=\(pageToken)"
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"?order=viewCount&\(maxResults)&regionCode=PK&q=&type=video&\(pageToken)&channelId=UCkvPHvcNlWzHEu_z5RKAeEA&key=AIzaSyBv-ZhhhyQx8EvHIGZGtA5I6QMkxMmA57M&part=snippet" , responseType: YoutubeHomeResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil , params:nil)
//      
//      restClient.getModel()
//   }
//   
//   func getMostLikedContent(maxResults:Int,pageToken:String) {
//      let maxResults = "maxResults=\(maxResults)"
//      let pageToken = "pageToken=\(pageToken)"
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"?order=rating&\(maxResults)&myRating=like&q=&\(pageToken)&channelId=UCkvPHvcNlWzHEu_z5RKAeEA&key=AIzaSyBv-ZhhhyQx8EvHIGZGtA5I6QMkxMmA57M&part=snippet&type=video" , responseType: YoutubeHomeResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil , params:nil)
//      
//      restClient.getModel()
//   }
//   
//   func getFullTracks(maxResults:Int,pageToken:String) {
//      let maxResults = "maxResults=\(maxResults)"
//      let pageToken = "pageToken=\(pageToken)"
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"https://www.googleapis.com/youtube/v3/playlistItems?order=%3CORDER_BY%3E&\(pageToken)&\(maxResults)&playlistId=PLAZ1yCpDGf8bbSjNURXQH1NW65ZH7FUj6&pageToken=&channelId=UCkvPHvcNlWzHEu_z5RKAeEA&key=AIzaSyBv-ZhhhyQx8EvHIGZGtA5I6QMkxMmA57M&part=snippet" , responseType: YoutubeCategoriesResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil , params:nil)
//      
//      restClient.getModel()
//   }
//   
//   
//   func getCategories(maxResults:Int,pageToken:String) {
//      let maxResults = "maxResults=\(maxResults)"
//      let pageToken = "pageToken=\(pageToken)"
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"https://www.googleapis.com/youtube/v3/playlists?order=viewCount&\(pageToken)&\(maxResults)&regionCode=PK&q=&type=video&channelId=UCkvPHvcNlWzHEu_z5RKAeEA&key=AIzaSyBv-ZhhhyQx8EvHIGZGtA5I6QMkxMmA57M&part=snippet&type=video" , responseType: YoutubeCategoriesResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil , params:nil)
//      
//      restClient.getModel()
//   }
//   
//   func getCategoryDetail(maxResults:Int,playListId:String,pageToken:String) {
//      let maxResults = "maxResults=\(maxResults)"
//      let pageToken = "pageToken=\(pageToken)"
//      let restClient = RestAPIFacade(delegate: self.delegate!, requestType:"https://www.googleapis.com/youtube/v3/playlistItems?\(maxResults)&playlistId=\(playListId)&\(pageToken)&channelId=UCkvPHvcNlWzHEu_z5RKAeEA&key=AIzaSyBv-ZhhhyQx8EvHIGZGtA5I6QMkxMmA57M&part=snippet" , responseType: YoutubeCategoriesResModel.self, requestMethod: RequestMethod.GET, headers: nil, data: nil , params:nil)
//      
//      restClient.getModel()
//   }
//   
   
   
   
   
//   /*
//    *Care Team APIs
//    */
//   
//   //Not Tested
  
}

