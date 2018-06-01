//
//  IdealDogViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import SwiftyJSON

class IdealDogViewController: UIViewController {
    var criteria: DogCriteria?

    @IBOutlet private weak var dogSizeImage: UIImageView!
    @IBOutlet private weak var baby: UIButton!
    @IBOutlet private weak var young: UIButton!
    @IBOutlet private weak var adult: UIButton!
    @IBOutlet private weak var senior: UIButton!
    @IBOutlet private weak var large: UIButton!
    @IBOutlet private weak var medium: UIButton!
    @IBOutlet private weak var small: UIButton!
    
    private var selectedSize: dogSize?
    private var selectedAge: dogAge?
    
    @IBAction private func sizeSelected(_ sender: UIButton) {
        style(selected: sender, allButtons: [small, medium, large])
        if let title = sender.titleLabel?.text?.lowercased(), let image = UIImage(named: title)  {
            selectedSize = dogSize(rawValue: title)
            dogSizeImage.image = image
        }
    }
    
    @IBAction private func ageSelected(_ sender: UIButton) {
        style(selected: sender, allButtons: [baby, young, adult, senior])
        if let title = sender.titleLabel?.text?.lowercased() {
            selectedAge = dogAge(rawValue: title)
        }
    }
    
    private func style(selected: UIButton, allButtons: [UIButton?]) {
        for button in allButtons {
            if let label = button?.titleLabel {
                if button == selected {
                    label.font = UIFont (name: "Avenir-Black", size: 12)
                }
                else {
                    label.font = UIFont (name: "Avenir-Roman", size: 12)
                }
            }
        }
    }
    
    private func findDogBreeds(dogBreed: DogCriteria) -> [Dog]{
        var dogs: [Dog] = []
        
        if let path = Bundle.main.path(forResource: "dogs", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                if jsonObj != JSON.null {
                    for dog in jsonObj["breeds"] {
                        let breed = Dog(name: dog.1["name"].string! , description: dog.1["description"].string!)
                        dogs.append(breed)
                    }
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return dogs
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? UINavigationController
        
        let destination = navVC?.viewControllers.first as! FindDogsViewController
        if let dogBreed = criteria {
            dogBreed.age = selectedAge!
            destination.dogs = findDogBreeds(dogBreed: dogBreed)
            destination.dogBreed = dogBreed
        }
    }

}
