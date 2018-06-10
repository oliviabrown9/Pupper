//
//  DogBreeds.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation


class Breed {
    
    var name: String
    var imageUrl: String
    var expanded: Bool = false
    
    init(name: String) {
        self.name = name
        self.imageUrl = "google.com"
    }
    
    func getBreedImage(for name: String) -> String {
        return "https://google.com"
    }
}

class DogBreeds {
    private func findDogBreeds(dogBreed: DogCriteria) -> [Breed] {
        var dogs = possibleBreeds()
        // make a call to PetFinder API to get possible breeds
        // make a call to Dog API to get matching photo
        
        return dogs
    }
    
    func possibleBreeds() -> [Breed] {
        var foundBreeds = [Breed]()
        guard let apiUrl = URL(string: "https://api.petfinder.com/breed.list?key=f534d78deac933250456312a9ee37d22&animal=dog&format=json") else { return [] }
        URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedBreeds = try decoder.decode(RawServerResponse.self, from: data)
                for breed in decodedBreeds.rawData.breedContainer.breeds {
                    foundBreeds.append(Breed(name: breed.name))
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        return foundBreeds
    }
}

fileprivate struct RawServerResponse: Decodable {
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
