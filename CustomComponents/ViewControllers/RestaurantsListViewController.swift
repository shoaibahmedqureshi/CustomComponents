//
//  ViewController.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/3/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit



class RestaurantsListViewController: UIViewController , RestaurantViewModelDelegate  {
  
   @IBOutlet var tableView : RestaurantTableViewControl!

    var restaurantViewModel  : RestaurantViewModel?
    var weatherViewModel  : WeatherViewModel?
    var restaurantList : [Restaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    func createView() {
        restaurantViewModel = RestaurantViewModel.init()
        restaurantViewModel?.getRestaurants()
        let restaurant = Restaurant.init()
        restaurant.name = "ssdfsd"
        restaurantList.append(restaurant)
        updateUI()
    }
    
    func updateUI() {
        tableView?.setup(tableItems: self.restaurantList, refrencingViewController: self)
        tableView.reloadData()
    }
    
    
    func updateRestuarntData(restaurantList: [Restaurant]) {
        
    }
    
    

    

    
    


}

