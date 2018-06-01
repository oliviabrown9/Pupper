//
//  DogBreeds.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation


class Breed {
    
    var name: String
    var imageUrl: String
    var expanded: Bool = false
    
    init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
    func getBreedImage(for name: String) -> String {
        return "https://google.com"
    }
}

class DogBreeds {
    var breeds = [Breed]()
    
    private func findDogBreeds(dogBreed: DogCriteria) -> [Breed] {
        var dogs = [Breed]()
        
        // make a call to PetFinder API to get possible breeds
        // make a call to Dog API to get matching photo
        
        return dogs
    }
}
