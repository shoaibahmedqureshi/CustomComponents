//
//  RestaurantTableViewCell.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/7/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//


import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var restaurantImage : UIImageView!
    
    @IBOutlet var restaurantName : UILabel!
    @IBOutlet var locationName : UILabel!
    @IBOutlet var restaurantType : UILabel!
    @IBOutlet var rating : UILabel!
    @IBOutlet var reviews : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.autoresizesSubviews = false
        // self.translatesAutoresizingMaskIntoConstraints = false
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
