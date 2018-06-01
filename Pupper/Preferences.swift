//
//  Preferences.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

enum dogSize: String {
    case small = "small"
    case medium = "medium"
    case large = "large"
    case all = "all"
}

enum dogAge: String {
    case baby = "baby"
    case young = "young"
    case adult = "adult"
    case senior = "senior"
    case all = "all"
}

class DogCriteria {
    var zipCode: Int
    var sizeOfDog: dogSize = .all
    var age: dogAge = .all
    var breed: String?

    init(zipCode: Int) {
        self.zipCode = zipCode
    }
}
