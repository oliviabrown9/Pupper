//
//  IdealDogViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class IdealDogViewController: UIViewController {
    var criteria: DogCriteria?

    @IBOutlet private weak var dogSizeImage: UIImageView!
    @IBOutlet private weak var baby: UIButton!
    @IBOutlet private weak var young: UIButton!
    @IBOutlet private weak var adult: UIButton!
    @IBOutlet private weak var senior: UIButton!
    @IBOutlet private weak var large: UIButton!
    @IBOutlet private weak var medium: UIButton!
    @IBOutlet private weak var small: UIButton!
    
    private var selectedSize: dogSize? = .small
    private var selectedAge: dogAge? = .baby
    
    @IBAction private func sizeSelected(_ sender: UIButton) {
        style(selected: sender, allButtons: [small, medium, large])
        if let title = sender.titleLabel?.text?.lowercased(), let image = UIImage(named: title)  {
            selectedSize = dogSize(rawValue: title)
            dogSizeImage.image = image
        }
    }
    
    @IBAction private func ageSelected(_ sender: UIButton) {
        style(selected: sender, allButtons: [baby, young, adult, senior])
        if let title = sender.titleLabel?.text?.lowercased().uppercaseFirstLetter {
            selectedAge = dogAge(rawValue: title)
        }
    }
    
    private func style(selected: UIButton, allButtons: [UIButton?]) {
        for button in allButtons {
            if let label = button?.titleLabel {
                if button == selected {
                    label.font = UIFont (name: "Avenir-Black", size: 12)
                }
                else {
                    label.font = UIFont (name: "Avenir-Roman", size: 12)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FindDogsViewController, let dogBreed = criteria {
            if let selectedAge = selectedAge {
                dogBreed.age = selectedAge
            }
            destination.criteria = dogBreed
        }
    }
}

extension String {
    var uppercaseFirstLetter: String {
        guard let firstLetter = first else { return self }
        return String(firstLetter).uppercased() + dropFirst()
    }
}
