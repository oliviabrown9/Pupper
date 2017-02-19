//
//  FindDogsViewController.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import Alamofire


class FindDogsViewController: UITableViewController{

    
    var cellTapped = false
    var descriptCellIndex: NSIndexPath?
    var approvedDogs: [String] = []
    var dogBreed: DogPreference?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("approved dogs::::", approvedDogs)
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
        return approvedDogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BreedTableViewCell
        
        // 3
        cell.breedPhoto.image = #imageLiteral(resourceName: "labrador")
        cell.breedLabel.text = approvedDogs[indexPath.item]
        
        if cellTapped {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descript", for: descriptCellIndex as! IndexPath) as! DescriptTableViewCell
            cell.descriptLabel.text = "yoo b"
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let descriptionIndex = indexPath.item+1
        approvedDogs.insert(" ", at: descriptionIndex)
        
        cellTapped = true
        
        let descriptIndexPath = NSIndexPath(item: descriptionIndex, section: 0)
        descriptCellIndex = descriptIndexPath
//        let cell = tableView.dequeueReusableCell(withIdentifier: "descript", for: descriptIndexPath as IndexPath) as! DescriptTableViewCell
        
        
        
        tableView.reloadData()
        print("yooo")
    }
    
}

