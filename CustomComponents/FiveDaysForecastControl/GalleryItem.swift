//
//  GalleryItem.swift
//  UICollectionView_p1_Swift
//
//  Created by olxios on 20/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

import Foundation
/**
 This class Entity that represents a single Gallery Item.
 */
class GalleryItem {
    
    var itemImage: String
   /**
    This method initializes a single gallery item.
    */
    init(dataDictionary:Dictionary<String,String>) {
        itemImage = dataDictionary["itemImage"]!
    }
   /**
    This method calls the initializes the gallery item.
    */
    class func newGalleryItem(dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }
    
}
