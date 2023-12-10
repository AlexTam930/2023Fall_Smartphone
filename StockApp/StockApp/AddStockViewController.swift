//
//  AddStockViewController.swift
//  StockApp
//
//  Created by Alex on 2023/10/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class AddStockViewController: UIViewController {
    
    @IBOutlet weak var txtStock: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func addStockAction(_ sender: Any) {
        guard let stockSymbol = txtStock.text else {return}
        
        getStockInfo(symbol: stockSymbol).done { stockClass in
            print(stockClass)
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL)   // the file of realm
                try realm.write({
                    realm.add(stockClass, update: .modified)
                })
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("Error in adding data to the realm DB")
            }
        }
        .catch { error in
            print("Unable to get stock value \(error)")
        }
                
//        let url = "\(baseURL)profile/\(stockSymbol)?apikey=\(apiKey)"
//        print(url)
//            
//        AF.request(url).responseJSON { response in
//            if(response.error != nil){
//                print(response.error?.localizedDescription)
//                return
//            }
//            // We have valid data here
//            guard let rawData = response.data else {return}
//            guard let jsonArray = JSON(rawData).array else {return}
//            guard let stock = jsonArray.first else {return}
//            
//            let symbol = stock["symbol"].stringValue
//            let price = stock["price"].floatValue
//            let companyName = stock["companyName"].stringValue
//            let description = stock["description"].stringValue
//            
//            print(symbol)
//            print(price)
//            print(companyName)
//            print(description)
//            
//            let stockClass = StockClass()
//            
//            stockClass.symbol = symbol
//            stockClass.price = price
//            stockClass.companyName = companyName
//            stockClass.companyDescription = description
//            
//            
//            do {
//                let realm = try Realm()
//                print(realm.configuration.fileURL)   // the file of realm
//                try realm.write({
//                    realm.add(stockClass, update: .modified)
//                })
//                self.navigationController?.popViewController(animated: true)
//            }
//            catch {
//                print("Error in adding data to the realm DB")
//            }
//                
//                
//        }
    }
    
}
