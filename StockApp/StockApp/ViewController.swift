//
//  ViewController.swift
//  StockApp
//
//  Created by Alex on 2023/10/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // let stockName = ["MSFT", "TSLA", "META", "GOOG"]
    
    var stocksArray: [StockClass] = [StockClass]()
    var stockArrayShort: [StockQuoteShort] = [StockQuoteShort]()
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadStockValues()
    }
    
    func loadStockValues() {
        // read values from Local DB and populate the Table
        do {
            stocksArray = [StockClass]()
            let realm = try Realm()
            let stocks = realm.objects(StockClass.self)
            print(stocks)
            
            var stockSymbols: [String] = [String]()
            for stock in stocks {
//                stocksArray.append(stock)
                stockSymbols.append(stock.symbol)
            }
            //tblView.reloadData()
            
//            stockArrayShort = [StockQuoteShort]()
            getAllStockQuote(symbols: stockSymbols)
                .done { stockQuotes in
                    for stockQuote in stockQuotes {
                        let stockClass = StockClass()
                        stockClass.symbol = stockQuote.symbol
                        stockClass.price = stockQuote.price
                        self.stockArrayShort.append(stockClass)
                        print("\(stockQuote.symbol) \(stockQuote.price)")
                    }
                    self.tblView.reloadData()
                }
            
        } catch {
            print("Error in reading from Realm \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return stockName.count
//        return stocksArray.count
        return stockArrayShort.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // cell.textLabel?.text = stockName[indexPath.row]
        
        let symbol = stocksArray[indexPath.row].symbol
        
        // let price = stocksArray[indexPath.row].price
        let price = String(format: "%.2f", stocksArray[indexPath.row].price)
        
        cell.textLabel?.text = "\(symbol) : \(price)$"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromReralDB(stocksArray[indexPath.row])
            stocksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteFromReralDB(_ stock : StockClass) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(stock)
            }
        } catch {
            print("Error in deleting \(error)")
        }
    }
    

}

