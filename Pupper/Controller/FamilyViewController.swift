//
//  FamilyViewController.swift
//  Pupper
//
//  Created by Miriam Hendler on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController {
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}
    var dogBreed: DogPreference?
    var hasDog = false
    var hasChild = false
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var childImageView: UIImageView!
    @IBOutlet weak var dogCountLabel: UILabel!
    var childCount = 0 {
        didSet {
            childrenCountLabel.text = "\(childCount)"
        }
    }
    var dogCount = 0 {
        didSet {
            dogCountLabel.text = "\(dogCount)"
        }
    }
    @IBAction func minusChildPressed(_ sender: Any) {
        if childCount != 0 {
            hasChild = true
            childCount -= 1
            childrenCountLabel.textColor = .blue
        } else {
            hasChild = false
             childrenCountLabel.textColor = .black
             self.childImageView.image = UIImage(named: "child")
        }
    }
 
    @IBAction func plusChildPressed(_ sender: Any) {
            childCount += 1
        
        if childCount >= 1 {
            hasChild = true
            childrenCountLabel.textColor = .blue
            self.childImageView.image = UIImage(named: "selected child")
        }
        
    }
    
    @IBAction func minusDogPressed(_ sender: Any) {
        if dogCount != 0 {
            hasDog = true
            dogCount -= 1
            dogCountLabel.textColor = .blue
        } else {
            hasDog = false
            dogCountLabel.textColor = .black
             self.dogImageView.image = UIImage(named: "dog")
        }
    }
    @IBAction func plusDogPressed(_ sender: Any) {
            dogCount += 1
        
        if dogCount  >= 1 {
            hasDog = true
            dogCountLabel.textColor = .blue
            self.dogImageView.image = UIImage(named: "selected dog")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TypeOfPersonViewController
        
        if let dogBreed = dogBreed {
            dogBreed.hasChild = self.hasChild
            dogBreed.hasDog = self.hasDog
            destination.dogBreed = dogBreed
        }
    }

}
