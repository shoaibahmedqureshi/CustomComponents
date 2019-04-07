//
//  WeatherForecastViewController.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/7/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    var weatherView : WeatherForecastControl!
    @IBOutlet var contentView: UIView!
    var weatherViewModel  : WeatherViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        createForecastView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didClickRestaurantsButton), name: Notification.Name("DidClickRestaurantsButton"), object: nil) 
    }
    
    func createForecastView() {
        weatherViewModel = WeatherViewModel.init()
        weatherViewModel?.getTodaysWeather()
        let
        weatherView = WeatherForecastControl.init(frame:self.view.frame)
        self.view.addSubview(weatherView)
    }
    
    @objc func didClickRestaurantsButton() {
        self.performSegue(withIdentifier: "Restaurants", sender: self)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
