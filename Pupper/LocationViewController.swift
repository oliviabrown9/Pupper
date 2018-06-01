//
//  LocationViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var locationLabel: UILabel!
    private var criteria: DogCriteria?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!) {
            (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                let addressDict = placemark.addressDictionary as? [String: Any]
                if let city = addressDict?["City"], let state = addressDict?["State"] {
                    self.locationLabel.text = "\(city), \(state)"
                }
            }
        }
    }
    
    private func validateZipCode() -> Int? {
        if let locationText = textField.text {
            if locationText.count >= 5 {
                if let zipCode = Int(locationText) {
                    return zipCode
                }
            }
        }
        return nil
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction private func continuePressed(_ sender: UIButton) {
        if let zipCode = validateZipCode() {
            criteria = DogCriteria(zipCode: zipCode)
            self.performSegue(withIdentifier: "toIdealDog", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! IdealDogViewController
        destination.criteria = self.criteria
    }
}
