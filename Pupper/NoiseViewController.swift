//
//  NoiseViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class NoiseViewController: UIViewController {
    
    var dogBreed: DogPreference?
    
    @IBAction func unwindToThis(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var noiseLevelImageView: UIImageView!
    var noiseLevel = 0 {
        didSet {
            if noiseLevel == 0 {
                noiseLevelLabel.text = "a little"
                noiseLevelImageView.image = UIImage(named: "low noise")
            } else if noiseLevel == 1 {
                noiseLevelLabel.text = "some"
                noiseLevelImageView.image = UIImage(named: "medium noise")
            } else if noiseLevel == 2{
                noiseLevelLabel.text = "a lot of"
                noiseLevelImageView.image = UIImage(named: "high noise")
            }
        }
    }

    
    @IBOutlet weak var noiseLevelLabel: UILabel!
    @IBAction func minusButtonPressed(_ sender: Any) {
        if noiseLevel != 0 {
            noiseLevel -= 1
        }
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        if noiseLevel < 2 {
            noiseLevel += 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! IdealDogViewController
        if let dogBreed = dogBreed {
            destination.dogBreed = dogBreed
        }
    }
}
