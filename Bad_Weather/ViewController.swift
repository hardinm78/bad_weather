//
//  ViewController.swift
//  Bad_Weather
//
//  Created by Michael Hardin on 3/31/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tempLbl: UILabel!
    var temperture : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadWeatherDetails { 
            self.tempLbl.text = "\(self.temperture!)°"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadWeatherDetails(completed: DownloadComplete) {
        
        Alamofire.request(.GET, URL_WEATHER).responseJSON { response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = list[0] ["main"] as? Dictionary<String,AnyObject> {
                        print(main)
                        
                        let tempK = main["temp"] as? Int
                        
                        let tempF = Double(tempK!) * (9/5) - 459.67
                        
                        
                        self.temperture = Int(tempF)
                        
                        completed()
                    }
                    
                    
                    
                    
                }
                
            }
        }
        
        
    }
    

}

