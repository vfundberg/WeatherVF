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

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
}

class WeatherTableViewController: UITableViewController, UISearchResultsUpdating {
   
    let URL = "http://api.openweathermap.org/data/2.5/weather"
    let APPID = "941747b308c30b1815669adf41489369"
    
    
    var tableViewData : [String] = []
    var searchController: UISearchController!
    var searchResult : [String] = []
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
        title = "Städer"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        fillTableViewWithCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            searchResult = tableViewData.filter { $0.lowercased().contains(text.lowercased()) }
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
    func fillTableViewWithCities(){
        tableViewData = ["Göteborg","London","Paris","Stockholm","Bangkok","Helsinki","Krakow"]
    }

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
            return tableViewData.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell

        
        
        if shouldUseSearchResult {
            let cityName = searchResult[indexPath.row]
            let cityTemp = String(searchResult.count + indexPath.row)
            cell.cityLabel?.text = cityName
            cell.tempLabel?.text = cityTemp
        } else {
            let cityName = tableViewData[indexPath.row]
            let cityTemp = String(tableViewData.count + indexPath.row)
            cell.cityLabel?.text = cityName
            cell.tempLabel?.text = cityTemp
        }

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
