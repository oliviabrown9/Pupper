//
//  SelectDogTableViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import MessageUI

class SelectDogTableViewController: UITableViewController {
    
    private var selectedDog: Dog?
    var criteria: DogCriteria?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let zipCode = criteria?.zipCode, let selectedBreed = criteria?.breed, let size = getSizeString(), let age = criteria?.age {
            DogMatches().allMatches(in: "\(zipCode)", size: size, age: age.rawValue, breed: selectedBreed){ foundDogs in
                self.dogMatches = foundDogs
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogMatches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCell", for: indexPath) as? ChosenTableViewCell {
            cell.chosenDog = dogMatches[indexPath.row]
            return filledTableView(cell: cell)
        }
        let title = "Error"
        let message = "Unexepected error, sorry about that!"
        self.popOkAlertWith(title: title, message: message, from: self)
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dogMatches[indexPath.row].expanded = !self.dogMatches[indexPath.row].expanded
        tableView.reloadRows(at: [indexPath], with: .automatic)
        selectedDog = dogMatches[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dogMatches[indexPath.row].expanded { return 242 }
        else { return 148 }
    }
    
    private func filledTableView(cell: ChosenTableViewCell) -> ChosenTableViewCell {
        if let chosenDog = cell.chosenDog {
            cell.addressLabel.text = "\(chosenDog.city)" + ", " + "\(chosenDog.state)"
            cell.tableViewController = self
            cell.selectionStyle = .none
            guard let photoLink = URL(string: chosenDog.photo) else { return cell }
            cell.dogImageView.downloadedFrom(url: photoLink)
            downloadImageView(from: photoLink, for: cell.dogImageView) { imageView in
                cell.dogImageView = imageView
                self.blurViews(in: cell)
            }
            cell.dogNameLabel.text = chosenDog.dogName
            cell.expanded = chosenDog.expanded
            cell.detailView.isHidden = !cell.expanded
        }
        return cell
    }
    
    private func getSizeString() -> String? {
        if let sizeEnum = criteria?.sizeOfDog {
            switch sizeEnum {
            case .small:
                return "S"
            case .medium:
                return "M"
            case .large:
                return "L"
            }
        }
        return nil
    }
    
    func shareDog() {
        let message = "Check out this dog!"
        if let photoUrl = selectedDog?.photo, let link = NSURL(string: photoUrl) {
            let objectsToShare = [message, link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"), UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension")]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private var dogMatches: [Dog] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            if dogMatches.isEmpty {
                DispatchQueue.main.async {
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    generator.notificationOccurred(.error)
                }
                let title = "Unable to find matching dogs."
                let message = "Oh no! We couldn't find any dogs that match your criteria. Maybe try another search?"
                self.popOkAlertWith(title: title, message: message, from: self)
            }
        }
    }
    
    private func blurViews(in cell: ChosenTableViewCell) {
        if let image = cell.dogImageView.image {
            cell.blurImageViewOne = self.blur(image: image, in: cell.blurImageViewOne)
            cell.blurImageViewTwo = self.blur(image: image, in: cell.blurImageViewTwo)
        }
    }
    
    private func blur(image: UIImage, in view: UIImageView) -> UIImageView {
        view.image = image
        view.addBlurEffect()
        return view
    }
    
    private func downloadImageView(from url: URL, for imageView: UIImageView, completion: @escaping (UIImageView)->() ) {
        imageView.contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                imageView.image = image
                completion(imageView)
            }
            }.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapVC" {
            if let destination = segue.destination as? MapViewController, let chosenDog = selectedDog {
                destination.dogName = chosenDog.dogName
                destination.address = "\(chosenDog.street)" + ", " + "\(chosenDog.city)" + ", " + "\(chosenDog.state)" + ", " + "\(chosenDog.zip)"
            }
        }
        else {
            let destination = segue.destination as? CalendarViewController
            destination?.chosenDog = selectedDog
        }
    }
}

extension SelectDogTableViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        if let recipient = selectedDog?.phone {
            messageComposeVC.recipients = [recipient]
        }
        messageComposeVC.body = ""
        return messageComposeVC
    }
    
}
