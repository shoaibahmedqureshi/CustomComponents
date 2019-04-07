//
//  Slide.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/7/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

class Slide: UIView {
    
     @IBOutlet var lbl : UILabel!
    
    
    @IBAction func didClickRestuarantButton() {
        NotificationCenter.default.post(name: Notification.Name("DidClickRestaurantsButton"), object: nil, userInfo: nil)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
