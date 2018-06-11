//
//  SelectDogTableViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import MessageUI

class SelectDogTableViewController: UITableViewController {
    var theChosenOne: Dog?
    
    var criteria: DogCriteria?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let zipCode = criteria?.zipCode, let selectedBreed = criteria?.breed, let size = getSizeString(), let age = criteria?.age {
            DogMatches().allMatches(in: "\(zipCode)", size: size, age: age.rawValue, breed: selectedBreed){ foundDogs in
                self.dogMatches = foundDogs
            }
        }
    }
    
    private func getSizeString() -> String? {
        if let sizeEnum = criteria?.sizeOfDog {
            switch sizeEnum {
            case .small:
                return "S"
            case .medium:
                return "M"
            case .large:
                return "L"
            case .all:
                return "S"
            }
        }
        return nil
    }
    
    @IBAction func mapButtonPressed(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "MapVC")
//        self.present(controller, animated: true, completion: nil)
    }
    
    var dogMatches: [Dog] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            if dogMatches.isEmpty {
                let alertController = UIAlertController(title: "Unable to find matching dogs.", message: "Oh no! We couldn't find any dogs that match your criteria. Maybe try another search?", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in _ = self.navigationController?.popViewController(animated: true) })
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapVC" {
            if let destination = segue.destination as? MapViewController, let chosenDog = theChosenOne {
                destination.dogName = chosenDog.dogName
                destination.address = "\(chosenDog.street)" + ", " + "\(chosenDog.city)" + ", " + "\(chosenDog.state)" + ", " + "\(chosenDog.zip)"
            }

        }
        else {
            let destination = segue.destination as? CalendarViewController
            destination?.chosenDog = theChosenOne
        }
        
    }

    func shareDog() {
        let message = "Check out this dog!"
        
        // Set the link to share.
        if let photoUrl = theChosenOne?.photo, let link = NSURL(string: photoUrl) {
            let objectsToShare = [message, link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList, UIActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"), UIActivityType(rawValue: "com.apple.mobilenotes.SharingExtension")]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
