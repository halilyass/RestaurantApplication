//
//  Models.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 3.01.2023.
//

import Foundation
import CoreLocation

struct business : Codable {
    let id : String
    let name : String
    let imageUrl : URL
    let distance : Double
}

struct AllData : Codable {
    let businesses : [business]
}

struct Details : Decodable {
    let price : String
    let phone : String
    let rating : Double
    let name : String
    let isClosed : Bool
    let photos : [URL]
    let coordinates : CLLocationCoordinate2D
    let id : String
}

extension CLLocationCoordinate2D : Decodable {
    
    enum Keys : CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let cont = try decoder.container(keyedBy: Keys.self)
        let lat = try cont.decode(Double.self, forKey: .latitude)
        let long = try cont.decode(Double.self, forKey: .longitude)
        self.init(latitude: lat, longitude: long)
    }
    
}

struct User : Decodable {
    
    let imageUrl : URL
    let name : String
}

struct Review : Decodable {
    
    let rating : Double
    let commentText : String
    let user : User
}

struct Response : Decodable {
    let reviews : [Review]
}



