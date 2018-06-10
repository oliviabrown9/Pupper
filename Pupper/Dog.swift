//
//  Chosen.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

class Dog {
    
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

class DogMatches {
    
    func allMatches(completion: @escaping ([Dog])->() ) {
        var foundDogs = [Dog]()
        let breed = "dachshund"
        let location = "90071"
        let dogSize = "S"
        let dogAge = "Young"
        
//        URL(string: "https://api.petfinder.com/pet.find?key=f534d78deac933250456312a9ee37d22&animal=dog&location="
//            + location + "&breed=" + breed + "&size=" + dogSize + "&age=" + dogAge + "&format=json")
        if let apiUrl = URL(string: "https://api.petfinder.com/pet.find?key=f534d78deac933250456312a9ee37d22&animal=dog&location="
            + location + "&format=json") {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments)
                    print(jsonArray)
                    let decoder = JSONDecoder()
                    let decodedDogs = try decoder.decode(RawApiResponse.self, from: data)
                    for dog in decodedDogs.rawData.petContainer.dogs {
                        print(dog.name.value)
                        print(dog.options)
                        print(dog.contact)
                        break
                        
//                        self.getImageFor(breed: breed.name) { imageUrlString in
//                            if let imageUrl = URL(string: imageUrlString) {
//                                foundBreeds.append(Breed(name: breed.name, withImage: imageUrl))
//                                completion(foundBreeds)
//                            }
//                        }
                    }
                } catch let err {
                    print("Err", err)
                }
                }.resume()
        }
    }
}
    
    private struct RawApiResponse: Decodable {
        struct RawData: Decodable {
            var petContainer: PetContainer
            enum CodingKeys : String, CodingKey {
                case petContainer = "pets"
            }
        }
        
        struct PetContainer: Decodable {
            var dogs: [SingleDog]
            enum CodingKeys : String, CodingKey {
                case dogs = "pet"
            }
        }
        
        struct SingleDog: Decodable {
            var age: Characteristic
            var description: Characteristic
            var photo: MediaContainer
            var contact: ContactContainer
            var options: OptionContainer
            var name: Characteristic
            enum CodingKeys : String, CodingKey {
                case age
                case description
                case photo = "media"
                case name
                case contact
                case options
            }
        }
        
        struct PhotoContainer: Decodable {
            var photos: [SinglePhoto]
            
            enum CodingKeys: String, CodingKey {
                case photos = "photo"
            }
        }
        
        struct MediaContainer: Decodable {
            var photoContainer: PhotoContainer
            enum CodingKeys: String, CodingKey {
                case photoContainer = "photos"
            }
        }
        
        struct SinglePhoto: Decodable {
            var url: String
            var size: String
            enum CodingKeys : String, CodingKey {
                case url = "$t"
                case size = "@size"
            }
        }
        
        struct Characteristic: Decodable {
            var value: String?
            enum CodingKeys : String, CodingKey {
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
        
        struct OptionContainer: Decodable {
            var option: [Characteristic]?
        }
        
        var rawData: RawData
        enum CodingKeys : String, CodingKey {
            case rawData = "petfinder"
        }
}
