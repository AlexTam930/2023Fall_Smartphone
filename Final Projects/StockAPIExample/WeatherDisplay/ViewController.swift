//
//  ViewController.swift
//
//  Created by Alex.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weatherValues: [WeatherClass] = [WeatherClass]()
    
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getStockValues(_ sender: Any) {
        print("0000000")
        let url = "\(baseURL)"
        print(url)
        SwiftSpinner.show("Getting Weather Values...")
        AF.request(url).responseJSON { response in
            print("11111")
            SwiftSpinner.hide()
            if response.error != nil {
                print(response.error?.localizedDescription ?? "Error")
                return
            }
            guard let rawData = response.data else {return}
            guard let jsonArray = JSON(rawData).array else {return}
            
            self.weatherValues = [WeatherClass]()
            for weatherJSON in jsonArray {
                // print("Stock : \(stockJSON)")
                let city = weatherJSON["city"].stringValue
                let temp = weatherJSON["temperature"].intValue
                let condition = weatherJSON["conditions"].stringValue
                
                let weather = WeatherClass()
                weather.city = city
                weather.temp = temp
                weather.condition = condition
                self.weatherValues.append(weather)
            }
            self.tblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = weatherValues[indexPath.row].city
        let temp = weatherValues[indexPath.row].temp
        let condition = weatherValues[indexPath.row].condition
        cell.textLabel?.text = "City: \(city), Temp: \(temp), Condition: \(condition)"
        return cell
    }
}

