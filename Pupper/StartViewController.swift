//
//  ViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

class StartViewController: UIViewController {
    var backgroundMusicPlayer = AVAudioPlayer()
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = 28
        pushNotifications()
        playBackgroundAudio()
    }
    
    private func pushNotifications() {
        // For testing purposes, I set the time interval to 30 seconds. In reality, I would set it to 3 days.
        let requestTrigger = UNTimeIntervalNotificationTrigger(timeInterval: (30), repeats: false)
        
        let requestContent = UNMutableNotificationContent()
        requestContent.title = "🐶"
        requestContent.subtitle = "We miss you!"
        requestContent.body = "Come check out all the cute dogs!"
        requestContent.badge = 1
        requestContent.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "ComeBackToApp", content: requestContent, trigger: requestTrigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    @IBAction func getStartedPressed(_ sender: UIButton) {
        backgroundMusicPlayer.stop()
    }
    private func playBackgroundAudio() {
        let backgroundMusic = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bark", ofType: "mp3")!)
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
            backgroundMusicPlayer.numberOfLoops = 1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch {
            print("Cannot play the file")
        }
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryAmbient, with: AVAudioSessionCategoryOptions.mixWithOthers)
    }
}

