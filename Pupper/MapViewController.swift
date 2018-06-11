//
//  MapViewController.swift
//  Pupper
//
//  Created by Olivia Brown on 6/4/18.
//  Copyright © 2018 Olivia. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    var address: String?
    
    var dogName: String?
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dogName = dogName, address != nil {
            titleLabel.text = "Navigating to \(dogName)"
            setMap()
        }
        else {
            let title = "Oops!"
            let message = "We don't have enough info to navigate to your dog!"
            self.popOkAlertWith(title: title, message: message, from: self)
        }
    }

    private func setMap() {
        let geoCoder = CLGeocoder()
        guard let address = address else { return }
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
                else {
                    let title = "Oh no!"
                    let message = "We couldn't find a valid location for the provided address :("
                    self.popOkAlertWith(title: , message: message, from: self)
                    return
            }
            let center = CLLocationCoordinate2D(latitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude))
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            annotation.coordinate = centerCoordinate
            if let dogName = self.dogName {
                annotation.title = dogName
            }
            
            self.mapView.addAnnotation(annotation)
        }
    }

    
    
    
}
