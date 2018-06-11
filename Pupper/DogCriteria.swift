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
}

enum dogAge: String {
    case baby = "Baby"
    case young = "Young"
    case adult = "Adult"
    case senior = "Senior"
}

class DogCriteria {
    var zipCode: Int
    var sizeOfDog: dogSize = .small
    var age: dogAge = .baby
    var breed: String?

    init(zipCode: Int) {
        self.zipCode = zipCode
    }
}
