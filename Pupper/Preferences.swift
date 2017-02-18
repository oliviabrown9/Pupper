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

class DogPreference {

    
    var zipCode : Int = 0
    var hasDog: Bool = false
    var hasChild: Bool = false
    var noiseLevel: Int = 0
    var sizeOfDog: size = .small
    var homeType: homeType = .house
    var personType: personType = .couch
   
    
    init(zipCode: Int) {
        self.zipCode = zipCode
    }
    
    
}
