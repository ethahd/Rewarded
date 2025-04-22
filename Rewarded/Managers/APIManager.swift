//
//  APIManager.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import Foundation
import CoreLocation

struct FoursquareResponse: Decodable {
    let results: [FoursquarePlace]
}

struct FoursquarePlace: Decodable {
    let fsq_id: String
    let name: String
    let distance: Double
    let categories: [Category]

    struct Category: Decodable {
        let name: String
    }
}

struct Place: Identifiable, Decodable {
    let id: String
    let name: String
    let distance: Double
    let categories: [String]
}

class PlacesAPIManager {
    static let shared = PlacesAPIManager()
    private init() {}

    private let baseURL = "https://api.foursquare.com/v3/places/search"
    private let apiKey = "fsq3j3Wvy1Rw8QB+cDJNf9t2jQWZyRiks+P4mEYbr00TL6g=" 

    func fetchNearbyPlaces(latitude: Double, longitude: Double, completion: @escaping ([Place]) -> Void) {
        guard let url = URL(string: "\(baseURL)?ll=\(latitude),\(longitude)&sort=DISTANCE&limit=20") else {
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let decoded = try? JSONDecoder().decode(FoursquareResponse.self, from: data)
            else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            let places = decoded.results.map {
                Place(
                    id: $0.fsq_id,
                    name: $0.name,
                    distance: $0.distance,
                    categories: $0.categories.map { $0.name }
                )
            }

            DispatchQueue.main.async {
                completion(places)
            }
        }.resume()
    }
}

