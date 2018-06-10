//
//  FindDogsViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class FindDogsViewController: UITableViewController{
    
    @IBAction func unwindToSelect(segue: UIStoryboardSegue) {}

    var selectedBreed: String?
    var assignedHeight: CGFloat = 50
    var index = 0
    
    var cellTapped = false
    var descriptCellIndex: NSIndexPath?
    var approvedDogs: [String] = []
    var dogs: [Breed] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var dogBreed: DogCriteria?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogBreeds().possibleBreeds() { foundBreeds in
            self.dogs = foundBreeds
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BreedTableViewCell
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: self.dogs[indexPath.row].imageUrl) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.breedPhoto.contentMode = .scaleToFill
                cell.breedPhoto.image = UIImage(data: data!)
            }
        }
        cell.breedLabel.text = dogs[indexPath.row].name
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
        if dogs[indexPath.row].expanded { return 222 }
        else { return 148 }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SelectDogTableViewController
        if segue.identifier == "breedSegue" {
            destination.selectedBreed = dogs[index].name
            destination.zipCode = dogBreed!.zipCode
        }
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    }

