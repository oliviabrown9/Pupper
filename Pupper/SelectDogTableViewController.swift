//
//  SelectDogTableViewController.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI

class SelectDogTableViewController: UITableViewController {

    var zipCode: Int?
    var selectedBreed: String?
    var chosenDogs: [Chosen] = []
    var theChosenOne: Chosen?
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dogBreed.age = .Baby
//        dogBreed.hasChild = false
//        dogBreed.hasDog = false
//        dogBreed.homeType = .apartment
//        dogBreed.sizeOfDog = .small
    
        setChosenClass { (chosenDog) in
            self.chosenDogs = chosenDog
            print(self.chosenDogs)
            
          print(self.selectedBreed)
        self.title = self.selectedBreed
        }
        
    
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }

    // MARK: - Table view data source
    func setChosenClass(callback: @escaping (([Chosen])->())) {
        
        let location = "\(zipCode!)"
        let breed = selectedBreed!
        let dogAge = "Young"
        
        var chosens: [Chosen] = []
        print(location, breed, dogAge)
        
        
        
        let url =
        "https://api.petfinder.com/pet.find?key=f534d78deac933250456312a9ee37d22&location=\(location)&animal=dog&breed=\(breed)&age=\(dogAge)&format=json"
        
        Alamofire.request("\(url)").responseJSON { response in
            print(response.result)   // hopefully success
            
            if let value = response.result.value {
                let json = JSON(value)
                
                print("JSON: \(json)")
                var petArray = json["petfinder"]["pets"]["pet"]
                
                for index in 0..<petArray.count {
                let name = petArray[index]["name"]["$t"].string!
                
                let photo = petArray[index]["media"]["photos"]["photo"][0]["$t"].string ?? ""
                
                let shelterStreet = petArray[index]["contact"]["address1"]["$t"].string ?? ""
                
                let shelterCity = petArray[index]["contact"]["city"]["$t"].string ?? "Suffern"
                
                let shelterState = petArray[index]["contact"]["state"]["$t"].string ?? "NY"
                
                let shelterPhone = petArray[index]["contact"]["phone"]["$t"].int ?? 8457686544
                
                let shelterEmail = petArray[index]["contact"]["email"]["$t"].string ?? "dogsupforadoption@aol.com"
                    
                
                let shelterCityState = "\(shelterCity), \(shelterState)"
                  
                let chosen = Chosen(dogName: name, photo: photo, street: shelterStreet, citystate: shelterCityState, phone: shelterPhone, email: shelterEmail, trained: self.randomBool(), hadShots: self.randomBool())
                    
                    chosens.append(chosen)
                    
                }
                callback(chosens)
                self.tableView.reloadData()
            }
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return chosenDogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCell", for: indexPath) as! ChosenTableViewCell
        let chosenDog = chosenDogs[indexPath.row]
        cell.addressLabel.text = "\(chosenDog.citystate)"
//        cell.dogImageView.image = UIImage(named: chosenDog.photo)
        cell.tableViewController = self
        cell.selectionStyle = .none
        
        cell.dogImageView.downloadedFrom(link: "\(chosenDog.photo)")
    
        cell.blurImageViewOne.downloadedFrom(link: "\(chosenDog.photo)")
        cell.blurImageViewOne.addBlurEffect()
        
        cell.blurImageViewTwo.downloadedFrom(link: "\(chosenDog.photo)")
        cell.blurImageViewTwo.addBlurEffect()
        print(chosenDog.photo)
        cell.dogNameLabel.text = chosenDog.dogName
        
        if chosenDog.hadShots {
        cell.hasShotsImageView.image = UIImage(named: "check")
        } else {
         cell.hasShotsImageView.image = UIImage(named: "uncheck")
        }
        if chosenDog.trained {
            cell.houseTrainedImageVIew.image = UIImage(named: "check")
        } else {
            cell.houseTrainedImageVIew.image = UIImage(named: "uncheck")
        }
        var time = arc4random_uniform(12) + 1
        
        cell.timeInShelterLabel.text = "\(time) months"
        
        cell.chosenDog = chosenDogs[indexPath.row]
        
        cell.expanded = chosenDog.expanded
        cell.detailView.isHidden = !cell.expanded
        
        return cell
    }
    
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.chosenDogs[indexPath.row].expanded = !self.chosenDogs[indexPath.row].expanded
        tableView.reloadRows(at: [indexPath], with: .automatic)
        theChosenOne = chosenDogs[indexPath.row]
        
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if chosenDogs[indexPath.row].expanded {
            
            return 242
        }
            
        else{return 148}
    }
    
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CalendarViewController
        destination.chosenDog = theChosenOne
        destination.selectedBreed = selectedBreed
        
//        destination.dogBreed = dogBreed
    }
    
    


}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

