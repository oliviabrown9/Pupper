//
//  DogMatches.swift
//  Pupper
//
//  Created by Olivia Brown on 6/1/18.
//  Copyright © 2018 Olivia. All rights reserved.
//

import Foundation

class DogMatches {
    
    func allMatches(in location: String, size: String, age: String, breed: String, completion: @escaping ([Dog])->() ) {
        if let apiUrl = URL(string: "https://api.petfinder.com/pet.find?key=f534d78deac933250456312a9ee37d22&animal=dog&location="
            + location + "&breed=" + breed + "&size=" + size + "&age=" + age + "&format=json") {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                guard let data = data else { return }
                let foundDogs = self.addDogs(fromData: data)
                completion(foundDogs)
                }.resume()
        }
    }
    
    private func addDogs(fromData data: Data) -> [Dog] {
        var foundDogs = [Dog]()
        do {
            let decoder = JSONDecoder()
            let decodedDogs = try decoder.decode(RawApiResponse.self, from: data)
            for dog in decodedDogs.rawData.petContainer.dogs {
                let contactInfo = dog.contact
                if let photoArray = dog.photo.photoContainer?.photos, let selectedPhoto = getLargePhoto(from: photoArray) {
                    foundDogs.append(Dog(dogName: dog.name.value, photo: selectedPhoto.url, street: contactInfo.address1?.value, city: contactInfo.city?.value, state: contactInfo.state?.value, phone: contactInfo.phone?.value, email: contactInfo.email?.value, zip: contactInfo.zip?.value ))
                }
            }
        } catch let err {
            print(err)
        }
        return foundDogs
    }
    
    private func getLargePhoto(from photoArray: [RawApiResponse.SinglePhoto]) -> RawApiResponse.SinglePhoto? {
        for photo in photoArray {
            if photo.size == "x" {
                return photo
            }
        }
        return nil
    }
    
    private struct RawApiResponse: Decodable {
        struct RawData: Decodable {
            var petContainer: PetContainer
            private enum CodingKeys : String, CodingKey {
                case petContainer = "pets"
            }
        }
        
        struct PetContainer: Decodable {
            var dogs: [SingleDog]
            private enum CodingKeys : String, CodingKey {
                case dogs = "pet"
            }
        }
        
        struct SingleDog: Decodable {
            var age: Characteristic
            var photo: MediaContainer
            var contact: ContactContainer
            var name: Characteristic
            private enum CodingKeys : String, CodingKey {
                case age
                case photo = "media"
                case name
                case contact
            }
        }
        
        struct PhotoContainer: Decodable {
            var photos: [SinglePhoto]?
            private enum CodingKeys: String, CodingKey {
                case photos = "photo"
            }
        }
        
        struct MediaContainer: Decodable {
            var photoContainer: PhotoContainer?
            private enum CodingKeys: String, CodingKey {
                case photoContainer = "photos"
            }
        }
        
        struct SinglePhoto: Decodable {
            var url: String?
            var size: String?
            private enum CodingKeys : String, CodingKey {
                case url = "$t"
                case size = "@size"
            }
        }
        
        struct Characteristic: Decodable {
            var value: String?
            private enum CodingKeys : String, CodingKey {
                case value = "$t"
            }
        }
        
        struct ContactContainer: Decodable {
            var address1: Characteristic?
            var address2: Characteristic?
            var city: Characteristic?
            var state: Characteristic?
            var zip: Characteristic?
            var email: Characteristic?
            var phone: Characteristic?
        }
        
        var rawData: RawData
        private enum CodingKeys : String, CodingKey {
            case rawData = "petfinder"
        }
    }
}
