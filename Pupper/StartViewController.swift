//
//  ViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation
import PassKit
import StoreKit

class StartViewController: UIViewController {
    
    private var list = [SKProduct]()
    private var p = SKProduct()
    private var backgroundMusicPlayer = AVAudioPlayer()
    
    @IBOutlet private weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = 28
        pushNotifications()
        if !SharingManager.sharedInstance.didRemoveAudio {
            playBackgroundAudio()
        }
        addApplePayPaymentButtonToView()
        
        if(SKPaymentQueue.canMakePayments()) {
            let productID: NSSet = NSSet(object: "noAudio")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        }
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
    
    @objc private func applePayButtonTapped(sender: UIButton) {
        let networks: [PKPaymentNetwork] = [.amex, .masterCard, .visa]
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: networks) {
            let request = donateRequest(for: networks)
            if let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request) {
                authorizationViewController.delegate = self
                present(authorizationViewController, animated: true, completion: nil)
            }
        }
        else {
            let title = "Unsupported payment"
            let message = "Oops, your device does not support this ApplePay method."
            self.presentOkAlertWith(title: title, message: message, from: self)
        }
    }
    
    private func donateRequest(for networks: [PKPaymentNetwork]) -> PKPaymentRequest {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.pupper"
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.supportedNetworks = networks
        request.merchantCapabilities = .capability3DS
        let donation = PKPaymentSummaryItem(label: "$10 donation", amount: NSDecimalNumber(decimal:10.00), type: .final)
        request.paymentSummaryItems = [donation]
        
        return request
    }

    @IBAction private func removeMusic(_ sender: UIButton) {
        for product in list {
            let prodID = product.productIdentifier
            if prodID == "noAudio" {
                p = product
                buyProduct()
            }
        }
    }
    
    private func buyProduct() {
        let pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
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

extension StartViewController: PKPaymentAuthorizationViewControllerDelegate {
    private func addApplePayPaymentButtonToView() {
        let paymentButton = PKPaymentButton(paymentButtonType: .donate, paymentButtonStyle: .white)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(paymentButton)
        
        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension StartViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let myProduct = response.products
        for product in myProduct {
            list.append(product)
        }
    }
}

extension StartViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction: AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            switch trans.transactionState {
            case .purchased:
                let prodID = p.productIdentifier
                switch prodID {
                case "noAudio":
                    SharingManager.sharedInstance.didRemoveAudio = true
                    backgroundMusicPlayer.stop()
                default:
                    print("iap not found")
                }
                queue.finishTransaction(trans)
            case .failed:
                queue.finishTransaction(trans)
                break
            default:
                break
            }
        }
    }
}

extension UIViewController {
    func presentOkAlertWith(title: String, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func popOkAlertWith(title: String, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in _ = self.navigationController?.popViewController(animated: true) })
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

