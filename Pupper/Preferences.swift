//
//  Preferences.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import Foundation

enum adoptionType {
    case adopt
    case foster
}

enum homeType {
    case house
    case apartment
}

enum size {
    case small
    case medium
    case large
}
enum personType {
    case couch
    case walk
    case adventure
}
enum age {
    case puppy
    case young
    case adult
    case senior
}

class DogPreference {

    
    var zipCode : Int = 0
    var hasDog: Bool = false
    var hasChild: Bool = false
    var sizeOfDog: size = .small
    var homeType: homeType = .house
    var personType: personType = .couch
    var age: age = .puppy
   
    
    init(zipCode: Int) {
        self.zipCode = zipCode
    }
    
    
}
