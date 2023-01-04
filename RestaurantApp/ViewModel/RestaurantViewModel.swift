//
//  RestaurantViewModel.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 3.01.2023.
//

import Foundation

struct RestaurantViewModel {
    let id : String
    let placeName : String
    let imageUrl : URL
    let distance : String
    
    init(place : business) {
        self.id = place.id
        self.placeName = place.name
        self.imageUrl = place.imageUrl
        self.distance = "\(String(format: "%.2f", place.distance/1000))"
    }
}
