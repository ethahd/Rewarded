//
//  HomeView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import SwiftUI
import CoreLocation
import SwiftData

struct HomeView: View {
    @ObservedObject private var locationManager = LocationManager()
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var places: [Place] = []
    @State private var isLoading = false
    @Query(filter: nil, sort: [SortDescriptor(\CreditCard.name)]) private var cards: [CreditCard]

    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Finding places near you...")
                        .padding()
                } else if places.isEmpty {
                    VStack(spacing: 12) {
                        Text("No places found.")
                            .foregroundColor(.gray)

                        Button(action: {
                            if let location = currentLocation {
                                fetchNearbyPlaces(for: location)
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("Try Again")
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()

                } else {
                    List(places) { place in
                        let matches = RewardCalculator.bestCards(for: place.categories, from: cards)
                        HStack(alignment: .top, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(place.name)
                                    .font(.headline)

                                Text("Distance: \(Int(place.distance)) meters")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                if !place.categories.isEmpty {
                                    Text("Categories: \(place.categories.joined(separator: ", "))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }

                            Spacer()

                            if let top = matches.first {
                                HStack(alignment: .top, spacing: 8) {
                                    Image(top.card.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 26)
                                        .cornerRadius(4)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(top.card.name)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)

                                        if let matchingCategory = bestMatchingCategory(for: top.card, in: place.categories) {
                                            Text("\(matchingCategory.capitalized): \(top.reward)")
                                                .font(.caption2)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.blue.opacity(0.1))
                                                .foregroundColor(.blue)
                                                .clipShape(Capsule())
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        if let location = currentLocation {
                            fetchNearbyPlaces(for: location)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Rewarded.")
                        .font(.largeTitle.bold())
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("Plat"), Color("Gold")]), startPoint: .top, endPoint: .bottom))
                }
            }
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
        .onReceive(locationManager.$lastKnownLocation) { newLocation in
            if let newLocation = newLocation,
               currentLocation?.latitude != newLocation.latitude ||
               currentLocation?.longitude != newLocation.longitude {
                currentLocation = newLocation
                fetchNearbyPlaces(for: newLocation)
            }
        }
    }
    
    private func fetchNearbyPlaces(for location: CLLocationCoordinate2D) {
        print("Fetching places for lat: \(location.latitude), lon: \(location.longitude)")
        isLoading = true
        PlacesAPIManager.shared.fetchNearbyPlaces(
            latitude: location.latitude,
            longitude: location.longitude
        ) { fetchedPlaces in
            self.places = fetchedPlaces
            self.isLoading = false
        }
    }
    
    private func bestMatchingCategory(for card: CreditCard, in businessCategories: [String]) -> String? {
        for category in businessCategories {
            if card.rewardCategories.keys.contains(where: { $0.lowercased() == category.lowercased() }) {
                return category
            }
        }
        return "Other"
    }

}


#Preview {
    HomeView()
}
