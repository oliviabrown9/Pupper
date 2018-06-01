//
//  LocationViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    var dogBreed: DogPreference?
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!) {
            (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                let addressDict = placemark.addressDictionary as? [String: Any]
                if let city = addressDict?["City"], let state = addressDict?["State"] {
                    if let locationText = textField.text, let locationInt = Int(locationText) {
                        if locationText.count >= 5 {
                            self.locationLabel.text = "\(city), \(state)"
                            self.dogBreed = DogPreference(zipCode: locationInt)
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! IdealDogViewController
        destination.dogBreed = self.dogBreed
    }
}
