//
//  Chosen.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import Foundation

class Chosen {
    
    var dogName: String
    var photo: String = ""
    var street: String
    var citystate: String
    var phone: Int = 0
    var email: String = ""
    var trained: Bool
    var hadShots: Bool
    var expanded: Bool = false
    
    init(dogName: String, photo: String, street: String, citystate: String, phone: Int, email: String, trained: Bool, hadShots:Bool) {
        self.dogName = dogName
        self.phone = phone
        self.photo = photo
        self.street = street
        self.citystate = citystate
        self.email = email
        self.trained = trained
        self.hadShots = hadShots
    }

}
