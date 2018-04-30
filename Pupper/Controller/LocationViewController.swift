//
//  LocationViewController.swift
//  Pupper
//
//  Created by Olivia Brown on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import CoreLocation


class LocationViewController: UIViewController {
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    var dogBreed: DogPreference?
    @IBAction func continueButtonPressed(_ sender: Any) {
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!) {
            (placemarks, error) -> Void in
            // Placemarks is an optional array of CLPlacemarks, first item in array is best guess of Address
            
            if let placemark = placemarks?[0] {
                
                let addressDict = placemark.addressDictionary as? [String: Any]
                let city = addressDict?["City"] as! String
                let state = addressDict?["State"] as! String
                
                if (textField.text?.count)! >= 5{
                self.locationLabel.text = "\(city), \(state)"
                self.dogBreed = DogPreference(zipCode: Int(textField.text!)!)
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HomeViewController
        destination.dogBreed = self.dogBreed
    }
}
