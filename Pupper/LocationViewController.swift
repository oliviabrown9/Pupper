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
        addTapToDismiss()
        setUpLocationManager()
    }
    
    private func addTapToDismiss() {
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            fillLocationLabel(from: text)
        }
        
    }
    
    private func fillLocationLabel(from zipcode: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(zipcode) {
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
        locationManager.stopUpdatingLocation()
        let destination = segue.destination as! IdealDogViewController
        destination.criteria = self.criteria
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate {
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations[0] as CLLocation, completionHandler: {(placemarks, error) -> Void in
            guard error == nil else { return }
            if let placemarks = placemarks, placemarks.count > 0 {
                let pm = placemarks[0]
                guard let zip = pm.postalCode else { return }
                self.textField.text = zip
                self.fillLocationLabel(from: zip)
            }
            else {
                let title = "Oops"
                let message = "Please enter your zipcode manually. Sorry about that!"
                self.presentOkAlertWith(title: title, message: message, from: self)
            }
        })
    }
}
