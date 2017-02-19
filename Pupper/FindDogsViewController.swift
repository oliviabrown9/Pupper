//
//  FindDogsViewController.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FindDogsViewController: UITableViewController{

    
    var cellTapped = false
    var descriptCellIndex: NSIndexPath?
    var approvedDogs: [String] = []
    var dogs: [Dog] = []
    var dogBreed: DogPreference?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("approved dogs::::", dogs)
        print("dog breed info", dogBreed?.zipCode)
        
        // MARK: API call setup
        
        let location = "90071" // replace with location from preferences struct
        let breed = "labrador" // replace with breed from preferences struct
        let age = "baby" // replace with age from preferences struct
        
        let url = "https://api.petfinder.com/pet.find?key=f534d78deac933250456312a9ee37d22&location=\(location)&animal=dog&breed=\(breed)&age=\(age)&format=json"
        
        Alamofire.request("\(url)").responseJSON { response in
            print(response.result)   // hopefully success
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BreedTableViewCell
        
        // 3
        print(dogs[0].name)
        cell.breedPhoto.image = UIImage(named: "\(dogs[indexPath.item].name).jpg")
        cell.breedLabel.text = dogs[indexPath.row].name
        
        print(dogs[indexPath.item].name)
        print(UIImage(named: "\(dogs[indexPath.item].name).jpg"))
        if cellTapped {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descript", for: descriptCellIndex as! IndexPath) as! DescriptTableViewCell
            cell.descriptLabel.text = dogs[indexPath.row].description
            cell.selectionStyle = .none
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dummyDog = Dog(name: " ", description: " ")
        let descriptionIndex = indexPath.item+1
        dogs.insert(dummyDog, at: descriptionIndex)
        
        cellTapped = true
        
        let descriptIndexPath = NSIndexPath(item: descriptionIndex, section: 0)
        descriptCellIndex = descriptIndexPath

        
        
        
        tableView.reloadData()
        print("yooo")
    }
    
}

