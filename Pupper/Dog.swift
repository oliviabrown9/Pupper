//
//  Chosen.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

class Dog {
    
    var dogName: String
    var photo: String
    var street: String
    var city: String
    var state: String
    var phone: String
    var email: String
    var zip: String
    var expanded: Bool = false
    
    init(dogName: String?, photo: String?, street: String?, city: String?, state: String?, phone: String?, email: String?, zip: String?) {
        self.dogName = dogName ?? ""
        self.phone = phone ?? ""
        self.photo = photo ?? ""
        self.street = street ?? ""
        self.city = city ?? ""
        self.state = state ?? ""
        self.email = email ?? ""
        self.zip = zip ?? ""
    }
}


