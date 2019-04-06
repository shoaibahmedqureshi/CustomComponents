//
//  RestaurantTableViewControl.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/4/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

protocol RestaurantTableViewControlDelegate {
  func didClickTableItem(index:Int,selectedCategoryType:String)
}

let REUSABLEIDENTIFIER : String = "TableCellView"
let NIBNAME = "RestaurantTableViewCell"
class RestaurantTableViewControl: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var tableItems: [AnyObject] = []
    var refrencingViewController:UIViewController!
    

    
    func setup(tableItems : [AnyObject],refrencingViewController:UIViewController) {
        self.tableItems = tableItems
        self.refrencingViewController = refrencingViewController
        self.initilize()
        
    }
    
   func reloadTable() {
        self.reloadData()
    }
    
    func initilize() {
        let nib = UINib.init(nibName: NIBNAME, bundle: nil)
        self.register(nib, forCellReuseIdentifier:REUSABLEIDENTIFIER)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.dataSource = self
       // self.backgroundColor = UIColor.white
        self.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.tableItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: REUSABLEIDENTIFIER) as? RestaurantTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(NIBNAME, owner: self, options: nil)![0] as? RestaurantTableViewCell
            //cell?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell?.contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        if let list = tableItems  as? [RestaurantModel] {
            cell?.restaurantName.text = list[indexPath.row].name
            //cell?.restaurantType.text = list[indexPath.row].type
            //cell?.locationName.text = list[indexPath.row].location
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
