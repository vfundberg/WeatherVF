//
//  WeatherTableViewController.swift
//  WeatherVF
//
//  Created by Victor Fundberg on 2018-03-26.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol goBack {
    func updateUIFromFavorites(newCity : String)
}

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {
   
    let URL = "http://api.openweathermap.org/data/2.5/weather"
    let APPID = "941747b308c30b1815669adf41489369"
    
    let weatherData = WeatherData()
    var searchController: UISearchController!
    var searchResult : [String] = []
    var favoriteCities : [String] = []
    var cityList : [WeatherData] = []
    var backDelegate : goBack?
    
    var shouldUseSearchResult : Bool {
        if let t = searchController.searchBar.text {
            if t.isEmpty {
                return false
            }
        } else {
            return false
        }
        return searchController.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search for your city"
        definesPresentationContext = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            searchResult = favoriteCities.filter { $0.lowercased().contains(text.lowercased()) }
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
//    func fillTableViewWithCities(){
//        tableViewData = ["Göteborg","London","Paris","Stockholm","Bangkok","Helsinki","Krakow"]
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return favoriteCities.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        
        
        if shouldUseSearchResult {
            let cityName = searchResult[indexPath.row]
            cell.textLabel?.text = cityName
            
        } else {
            let cityName = favoriteCities[indexPath.row]
            cell.textLabel?.text = cityName
            
        }

        return cell
    }
 

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   

   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if shouldUseSearchResult {
            let city = searchResult[indexPath.row]
            backDelegate?.updateUIFromFavorites(newCity: city)
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        } else {
            let city = favoriteCities[indexPath.row]
            backDelegate?.updateUIFromFavorites(newCity: city)
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
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
