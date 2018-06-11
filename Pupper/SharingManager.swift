//
//  SharingManager.swift
//  Pupper
//
//  Created by Olivia Brown on 6/9/18.
//  Copyright © 2018 Olivia. All rights reserved.
//

import Foundation

class SharingManager {
    static let sharedInstance = SharingManager()
    
    var userDefaults: UserDefaults = UserDefaults.standard
    
    var didRemoveAudio: Bool = false {
        didSet {
            userDefaults.set(didRemoveAudio, forKey: "DidRemoveAudio")
        }
    }
    
    private init() {
        let storedDidRemoveAudio = userDefaults.bool(forKey: "DidRemoveAudio")
        didRemoveAudio = storedDidRemoveAudio
    }
}
