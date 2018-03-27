//
//  StartViewController.swift
//  WeatherVF
//
//  Created by Victor Fundberg on 2018-03-26.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class StartViewController: UIViewController {
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let weatherData =  WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
