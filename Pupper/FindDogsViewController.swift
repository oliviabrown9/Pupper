//
//  FindDogsViewController.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import Alamofire

class FindDogsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let key = "f534d78deac933250456312a9ee37d22"
        let location = "90071"
        let breed = "labrador"
        let age = "baby"

        let url = "http://api.petfinder.com/pet.find?key=\(key)&location=\(location)&animal=dog&breed=\(breed)&age=\(age)&format=json"
        
        Alamofire.request("\(url)").responseJSON { response in
            print(response.request!)  // original URL request for debugging
            print(response.response!) // HTTP URL response for debugging
            print(response.data!)     // server data for debugging
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

        
    }

}
