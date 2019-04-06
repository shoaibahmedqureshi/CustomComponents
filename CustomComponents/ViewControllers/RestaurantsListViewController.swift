//
//  ViewController.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/3/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit



class RestaurantsListViewController: UIViewController , RestaurantViewModelDelegate  {
  
    var tableView : RestaurantTableViewControl!
    @IBOutlet var sView: UIView!
    var restaurantViewModel  : RestaurantViewModel?
    var restaurantList : [Restaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantViewModel = RestaurantViewModel.init()
        restaurantViewModel?.getRestaurants()
        
        tableView = RestaurantTableViewControl.init()
        tableView.frame = CGRect.init(x:0 , y: 0 , width: 500, height:500)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.setup(tableItems: self.restaurantList, refrencingViewController: self)
        self.sView.translatesAutoresizingMaskIntoConstraints = false
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.sView.addSubview(tableView)
        tableView!.reloadData()

    }
    
    func updateRestuarntData(restaurantList: [Restaurant]) {
        self.restaurantList = restaurantList
    }
    
    

    

    
    


}

