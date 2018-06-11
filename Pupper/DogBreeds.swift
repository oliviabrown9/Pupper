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
}

class DogBreeds {
    
    func possibleBreeds(completion: @escaping ([Breed])->() )  {
        var foundBreeds = [Breed]()
        if let apiUrl = URL(string: "https://api.petfinder.com/breed.list?key=f534d78deac933250456312a9ee37d22&animal=dog&format=json") {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let decodedBreeds = try decoder.decode(RawApiResponse.self, from: data)
                    for breed in decodedBreeds.rawData.breedContainer.breeds {
                        self.getImageFor(breed: breed.name) { imageUrlString in
                            if let imageUrl = URL(string: imageUrlString) {
                                foundBreeds.append(Breed(name: breed.name, withImage: imageUrl))
                                completion(foundBreeds)
                            }
                        }
                    }
                } catch let err {
                    print(err)
                }
                }.resume()
        }
    }
    
    private func getImageFor(breed: String, completion: @escaping (String)->() ) {
        var imageUrl = String()
        if let apiUrl = URL(string: "https://dog.ceo/api/breed/" + breed.lowercased() + "/images/random")  {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let decodedUrl = try decoder.decode(ImageUrl.self, from: data)
                    imageUrl = decodedUrl.url
                } catch let err {
                    print(err)
                }
                completion(imageUrl)
                }.resume()
        }
    }
    
    private struct ImageUrl: Decodable {
        var url: String
        private enum CodingKeys : String, CodingKey {
            case url = "message"
        }
    }
    
    private struct RawApiResponse: Decodable {
        struct RawData: Decodable {
            var breedContainer: BreedContainer
            private enum CodingKeys : String, CodingKey {
                case breedContainer = "breeds"
            }
        }
        
        struct BreedContainer: Decodable {
            var breeds: [SingleBreed]
            private enum CodingKeys : String, CodingKey {
                case breeds = "breed"
            }
        }
        
        struct SingleBreed: Decodable {
            var name: String
            private enum CodingKeys : String, CodingKey {
                case name = "$t"
            }
        }
        
        var rawData: RawData
        private enum CodingKeys : String, CodingKey {
            case rawData = "petfinder"
        }
    }
}
