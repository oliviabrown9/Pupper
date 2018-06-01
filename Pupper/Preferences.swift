//
//  Preferences.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

enum size {
    case small
    case medium
    case large
    case all
}

enum age: String {
    case baby = "baby"
    case young = "young"
    case adult = "adult"
    case senior = "senior"
    case all = "all"
}

class DogCriteria {
    var zipCode: Int
    var sizeOfDog: size = .all
    var age: age = .all
    var breed: String?

    init(zipCode: Int) {
        self.zipCode = zipCode
    }
}
