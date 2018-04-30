//
//  Preferences.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
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
enum age: String {
    case Baby = "Baby"
    case Young = "Young"
    case Adult = "Adult"
    case Senior = "Senior"
}

class DogPreference {

    
    var zipCode : Int = 0
    var hasDog: Bool = false
    var hasChild: Bool = false
    var sizeOfDog: size = .small
    var homeType: homeType = .house
    var personType: personType = .couch
    var age: age = .Baby
   
    
    init(zipCode: Int) {
        self.zipCode = zipCode
    }
    
    
}
