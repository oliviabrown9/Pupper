//
//  IdealDogViewController.swift
//  Pupper
//
//  Created by Olivia Brown on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import SwiftyJSON

class IdealDogViewController: UIViewController {
    var dogBreed : DogPreference?
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var dogSizeImage: UIImageView!
    
    @IBOutlet weak var young: UIButton!
    @IBOutlet weak var adult: UIButton!
    @IBOutlet weak var senior: UIButton!
    @IBOutlet weak var puppy: UIButton!
    
    @IBOutlet weak var hair: UIButton!
    @IBOutlet weak var hypo: UIButton!
    
    @IBOutlet weak var large: UIButton!
    @IBOutlet weak var medium: UIButton!
    @IBOutlet weak var small: UIButton!
       var matches: [String] = []
    var sizeOfDog: size?
    var age: age?
    @IBAction func smallPressed(_ sender: Any) {
        print("small button presssed")
        small.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        small.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        medium.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        medium.setTitleColor(.black, for: .normal)
        large.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        large.setTitleColor(.black, for: .normal)
        medium.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        sizeOfDog = .small
        dogSizeImage.image = #imageLiteral(resourceName: "selected_small")
    }
    
    @IBAction func mediumPressed(_ sender: Any) {
        medium.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        medium.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        small.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        small.setTitleColor(.black, for: .normal)
        large.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        large.setTitleColor(.black, for: .normal)
        sizeOfDog = .medium
        dogSizeImage.image = #imageLiteral(resourceName: "selected_medium")
    }
    
    @IBAction func largePressed(_ sender: Any) {
        small.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        small.setTitleColor(.black, for: .normal)
        medium.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        medium.setTitleColor(.black, for: .normal)
        large.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        large.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        sizeOfDog = .large
        dogSizeImage.image = #imageLiteral(resourceName: "large_selected")
    }
    
    @IBAction func puppyPressed(_ sender: Any) {
        young.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        young.setTitleColor(.black, for: .normal)
        puppy.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        puppy.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        adult.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        adult.setTitleColor(.black, for: .normal)
        senior.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        senior.setTitleColor(.black, for: .normal)
        age = .Baby
    }
    
    @IBAction func youngPressed(_ sender: Any) {
        young.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        young.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        puppy.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        puppy.setTitleColor(.black, for: .normal)
        adult.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        adult.setTitleColor(.black, for: .normal)
        senior.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        senior.setTitleColor(.black, for: .normal)
        age = .Young
    }
    
    @IBAction func adultPressed(_ sender: Any) {
        young.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        young.setTitleColor(.black, for: .normal)
        puppy.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        puppy.setTitleColor(.black, for: .normal)
        adult.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        adult.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        senior.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        senior.setTitleColor(.black, for: .normal)
        age = .Adult
    }
    
    @IBAction func seniorPressed(_ sender: Any) {
        young.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        young.setTitleColor(.black, for: .normal)
        puppy.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        puppy.setTitleColor(.black, for: .normal)
        adult.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        adult.setTitleColor(.black, for: .normal)
        senior.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        senior.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
        age = .Senior
    }
    
    @IBAction func hypoPressed(_ sender: Any) {
        hair.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        hair.setTitleColor(.black, for: .normal)
        hypo.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        hypo.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
    }
    
    @IBAction func hairPressed(_ sender: Any) {
        hypo.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        hypo.setTitleColor(.black, for: .normal)
        hair.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        hair.setTitleColor(UIColor(red:0.29, green:0.56, blue:0.89, alpha:1.0), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func getMatchesButtonPressed(_ sender: Any) {

    }

    
    func findDogBreeds(dogBreed: DogPreference) -> [Dog]{
        // MARK: Dog Types
     
        
        var dogs: [Dog] = []
        
        if let path = Bundle.main.path(forResource: "dogs", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                if jsonObj != JSON.null {
                    print("jsonData:\(jsonObj)")
                    
                    if dogBreed.homeType == .apartment {
                        for dog in jsonObj["apartment"] {
                            let breed = Dog(name: dog.1["name"].string! , description: dog.1["description"].string!)
                            dogs.append(breed)
                        }
                    }
                    else {
                        if dogBreed.hasChild {
                            for dog in jsonObj["forKids"] {
                                let breed = Dog(name: dog.1["name"].string! , description: dog.1["description"].string!)
                                dogs.append(breed)
                                
                            }
                        } else {
                            for dog in jsonObj["medium"] {
                                let breed = Dog(name: dog.1["name"].string! , description: dog.1["description"].string!)
                                dogs.append(breed)
                                
                            }
                        }
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
        if let dogBreed = dogBreed {
            dogBreed.age = age!
            destination.dogs = findDogBreeds(dogBreed: dogBreed)
            destination.dogBreed = dogBreed
        }
    }
}
