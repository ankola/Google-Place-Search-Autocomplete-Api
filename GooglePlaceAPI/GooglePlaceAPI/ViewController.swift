//
//  ViewController.swift
//  GooglePlaceAPI
//
//  Created by Aman Aggarwal on 15/03/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtSearch.delegate = self
    }

    
    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPlaceFromGoogle(search_place_string: textField.text!)
        return true
    }
    
    
    func searchPlaceFromGoogle(search_place_string : String) {
        
        let yourApiKey = "AIzaSyBCmiAi-SgtYNvYzuwwCNjR2rFDtdoOKlo"
        
        //for all Address Name Search From String
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(search_place_string)&key=\(yourApiKey)&sessiontoken=1234567890"

        //For One place dettails from string
//        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(search_place_string)&key=\(yourApiKey)"
        
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
            
            if error == nil {
                let jsonDict : [String:AnyObject] = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
                
                print(jsonDict)

//                var DescriptionData = [String]()
//                let Placedata : [[String : AnyObject]] = jsonDict["predictions"] as! [[String : AnyObject]]
//
//                DescriptionData = Placedata.map({ $0["description"] }) as! [String]
//
//                print(DescriptionData)
                
            } else {
                //we have error connection google api
                print(error?.localizedDescription as Any)
            }
        }
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

