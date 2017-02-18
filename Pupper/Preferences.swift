//
//  Preferences.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import Foundation

struct Preferences {

    enum adoptionType {
        case adopt
        case foster
    }
    
    enum homeType {
        case house
        case apartment
    }
    
    var zipCode : Int
    var numberOfDogs: Int
    var numberOfKids: Int
    var noiseLevel: Int
    
    enum size {
        case small
        case medium
        case large
    }
    
    
}
