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
    
//    if chosenDog.hadShots {
//        cell.hasShotsImageView.image = UIImage(named: "check")
//    } else {
//        cell.hasShotsImageView.image = UIImage(named: "uncheck")
//    }
//    if chosenDog.trained {
//        cell.houseTrainedImageVIew.image = UIImage(named: "check")
//    } else {
//        cell.houseTrainedImageVIew.image = UIImage(named: "uncheck")
//    }
//    let time = arc4random_uniform(12) + 1
//
//    cell.timeInShelterLabel.text = "\(time) months"
    
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

extension String {
    func convertToDictionary() -> Any? {
        
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
