//
//  FindDogsViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class FindDogsViewController: UITableViewController {
    
    var selectedBreed: String?
    var criteria: DogCriteria?
    private var index = 0
    
    private var dogs: [Breed] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        DispatchQueue.main.async {
            cell.breedPhoto.downloadedFrom(url: self.dogs[indexPath.row].imageUrl, contentMode: .scaleToFill)
        }
        cell.breedLabel.text = dogs[indexPath.row].name
        cell.expanded = dogs[indexPath.row].expanded
        cell.detailView.isHidden = !cell.expanded
        cell.tableViewController = self
        cell.layer.cornerRadius = 10
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
            if let criteria = criteria, let selectedBreed = selectedBreed {
                criteria.breed = selectedBreed
                destination.criteria = criteria
            }
        }
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
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
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

