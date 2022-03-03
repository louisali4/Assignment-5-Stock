//
//  StockViewController.swift
//  Stock
//
//  Created by Duyi Li on 3/2/22.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class StockViewController: UIViewController {

    @IBOutlet weak var txtStockSymbol: UITextField!
    
    @IBOutlet weak var lblStockPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func getStockPrice(_ sender: Any) {
        
        guard let symbol = txtStockSymbol.text else {return}
        

        
        let url = "\(shortQuoteURL)\(symbol.uppercased())?apikey=\(apiKey)"
        
        print(url)
        
        SwiftSpinner.show("Getting Stock Value for \(symbol)")
        
        
        AF.request(url).response { response in
            
            SwiftSpinner.hide(nil)
            
            if response.error != nil{
                print(response.error!)
                return
            }
           
            let stocks = JSON(response.data!).array
            
            guard let stock = stocks!.first else { return}
            
            print(stocks)
            
            let quote = QuoteShort()
            quote.symbol = stock["symbol"].stringValue
            quote.price = stock["price"].floatValue
            quote.volume = stock["volume"].intValue
            
            self.lblStockPrice.text = "\(quote.symbol) : \(quote.price) $"
        }
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
