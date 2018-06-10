//
//  DogBreeds.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation


class Breed {
    
    var name: String
    var imageUrl: URL
    var expanded: Bool = false
    
    init(name: String, withImage imageUrl: URL) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
    func getBreedImage(for name: String) -> String {
        return "https://google.com"
    }
}

class DogBreeds {
    private func findDogBreeds(dogBreed: DogCriteria) -> [Breed] {
        var dogs = [Breed]()
        // make a call to Dog API to get matching photo
        
        return dogs
    }
    
    func getImageFor(breed: String, completion: @escaping (String)->() ) {
        var imageUrl = String()
        if let apiUrl = URL(string: "https://dog.ceo/api/breed/" + breed.lowercased() + "/images/random")  {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let decodedUrl = try decoder.decode(ImageUrl.self, from: data)
                    imageUrl = decodedUrl.url
                } catch let err {
                    print("Err", err)
                }
                completion(imageUrl)
                }.resume()
        }
    }
    
    func possibleBreeds(completion: @escaping ([Breed])->() )  {
        var foundBreeds = [Breed]()
        if let apiUrl = URL(string: "https://api.petfinder.com/breed.list?key=f534d78deac933250456312a9ee37d22&animal=dog&format=json") {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let decodedBreeds = try decoder.decode(RawServerResponse.self, from: data)
                    for breed in decodedBreeds.rawData.breedContainer.breeds {
                        self.getImageFor(breed: breed.name) { imageUrlString in
                            if let imageUrl = URL(string: imageUrlString) {
                                foundBreeds.append(Breed(name: breed.name, withImage: imageUrl))
                            }
                            
                        }
                    }
                } catch let err {
                    print("Err", err)
                }
                }.resume()
        }
    }
    
    private struct ImageUrl: Decodable {
        var url: String
        enum CodingKeys : String, CodingKey {
            case url = "message"
        }
    }
    
    private struct RawServerResponse: Decodable {
        struct RawData: Decodable {
            var breedContainer: BreedContainer
            enum CodingKeys : String, CodingKey {
                case breedContainer = "breeds"
            }
        }
        
        struct BreedContainer: Decodable {
            var breeds: [SingleBreed]
            enum CodingKeys : String, CodingKey {
                case breeds = "breed"
            }
        }
        
        struct SingleBreed: Decodable {
            var name: String
            enum CodingKeys : String, CodingKey {
                case name = "$t"
            }
        }
        
        var rawData: RawData
        enum CodingKeys : String, CodingKey {
            case rawData = "petfinder"
        }
        
    }
    
    struct ServerResponse: Decodable {
        var allBreeds: [String]
        
        init(from decoder: Decoder) throws {
            let rawResponse = try RawServerResponse(from: decoder)
            
            allBreeds = [String]()
            for breed in rawResponse.rawData.breedContainer.breeds {
                allBreeds.append(breed.name)
            }
        }
    }
}
