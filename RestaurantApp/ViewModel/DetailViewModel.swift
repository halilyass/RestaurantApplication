//
//  DetailViewModel.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 4.01.2023.
//

import Foundation
import CoreLocation

struct DetailsViewModel {
    
    let placeName : String
    let phoneNumber : String
    let price : String
    let isClosed : String
    let rating : String
    let restaurantImages : [URL]
    let coordinates : CLLocationCoordinate2D
    let id : String
    
    init(detail : Details) {
        self.placeName = detail.name
        self.phoneNumber = detail.phone
        self.price = detail.price
        self.isClosed = detail.isClosed ? "Closed" : "Open"
        self.rating = "\(detail.rating) /5"
        self.restaurantImages = detail.photos
        self.coordinates = detail.coordinates
        self.id = detail.id
    }
}
