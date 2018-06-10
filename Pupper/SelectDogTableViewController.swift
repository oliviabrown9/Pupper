//
//  SelectDogTableViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import MessageUI

class SelectDogTableViewController: UITableViewController {
    
    var zipCode: Int?
    var selectedBreed: String?
    var theChosenOne: Dog?
    var size: String?
    var age: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        size = "S"
        age = "Young"
        selectedBreed = "Dalmatian"
        zipCode = 90071
        if let zipCode = zipCode, let selectedBreed = selectedBreed, let size = size, let age = age {
            DogMatches().allMatches(in: "\(zipCode)", size: size, age: age, breed: selectedBreed){ foundDogs in
                self.dogMatches = foundDogs
            }
        }
    }
    
    var dogMatches: [Dog] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}

override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dogMatches.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCell", for: indexPath) as! ChosenTableViewCell
    let chosenDog = dogMatches[indexPath.row]
    cell.addressLabel.text = "\(chosenDog.city)" + ", " + "\(chosenDog.state)"
    cell.tableViewController = self
    cell.selectionStyle = .none
    cell.dogImageView.downloadedFrom(link: "\(chosenDog.photo)")
    cell.blurImageViewOne.downloadedFrom(link: "\(chosenDog.photo)")
    cell.blurImageViewOne.addBlurEffect()
    cell.blurImageViewTwo.downloadedFrom(link: "\(chosenDog.photo)")
    cell.blurImageViewTwo.addBlurEffect()
    cell.dogNameLabel.text = chosenDog.dogName
    cell.chosenDog = dogMatches[indexPath.row]
    cell.expanded = chosenDog.expanded
    cell.detailView.isHidden = !cell.expanded
    
    return cell
}


override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.dogMatches[indexPath.row].expanded = !self.dogMatches[indexPath.row].expanded
    tableView.reloadRows(at: [indexPath], with: .automatic)
    theChosenOne = dogMatches[indexPath.row]
    
    
}
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if dogMatches[indexPath.row].expanded {
        
        return 242
    }
        
    else{return 148}
}
}
