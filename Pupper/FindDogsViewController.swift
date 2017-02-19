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
    
    @IBAction func unwindToSelect(segue: UIStoryboardSegue) {}

    var selectedBreed: String?
    var assignedHeight: CGFloat = 50
    var index = 0
    
    var cellTapped = false
    var descriptCellIndex: NSIndexPath?
    var approvedDogs: [String] = []
    var dogs: [Dog] = []
    var dogBreed: DogPreference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: API call setup
        
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
        cell.breedDescript.text = dogs[indexPath.row].description
        cell.expanded = dogs[indexPath.row].expanded
        cell.detailView.isHidden = !cell.expanded
        cell.tableViewController = self
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            self.dogs[indexPath.row].expanded = !self.dogs[indexPath.row].expanded
            tableView.reloadRows(at: [indexPath], with: .automatic)
            selectedBreed = self.dogs[indexPath.row].name
            index = indexPath.row
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dogs[indexPath.row].expanded {
            
            return 222
        }
            
        else{return 148}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SelectDogTableViewController
        if segue.identifier == "breedSegue" {
            print(index)
            destination.selectedBreed = dogs[index].name
            print(dogBreed!.zipCode)
            destination.zipCode = dogBreed!.zipCode
//            print(dogBreed)
//            destination.dogBreed = dogBreed!
        }
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    }

