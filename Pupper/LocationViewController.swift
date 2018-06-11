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
    private let locationManager = CLLocationManager()
    private var criteria: DogCriteria?
    private var mostRecentUserLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        setUpLocationManager()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!) {
            (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                if let city = placemark.locality, let state = placemark.administrativeArea {
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

// MARK: - CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate {
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations[0] as CLLocation, completionHandler: {(placemarks, error) -> Void in
            guard error != nil else { return }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.textField.text = pm.postalCode
            }
            else {
                let title = "Oops"
                let message = "Please enter your zipcode manually. Sorry about that!"
                self.presentOkAlertWith(title: title, message: message, from: self)
            }
        })
    }
}
